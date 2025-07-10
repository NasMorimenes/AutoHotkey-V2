#Include ..\MensageHooks\classes MensagesHook.ahk
#Include ..\Hooks\class HookUn.ahk
#Include ..\Hooks\class HookConfig.ahk
#Include ..\Hooks\class HookFree.ahk
#Include ..\Hooks\class HookInstall.ahk
#Include ..\Hooks\class HookStatus.ahk
#Include ..\Hooks\class FuncToHooks.ahk
#Include ..\Hooks\class HookIDs.ahk
#Include class NumericValues.ahk
#Include ..\Hooks\class HookCallbackTo.ahk
#Include ..\Hooks\SendMessageList-Script.ahk
#Include ..\Hooks\class HookCallNext.ahk
#Include ..\Hooks\IDsHook\classes IDsHook.ahk
;--------------------------------------------
;============================================
; Ver comentários abaixo
;============================================
;--------------------------------------------

myAxis := 0
Positriggers := 0
_Hook := 0
myInstallHook := 0
HookOff := false
IsOut    := NumericValues.Ref

msgButtom := RButtonDown()
_axis := SelectorScreen( msgButtom )
OutputDebug( _axis )
;Para testes
; O Script deve continuar até o desligamento do SetTimer
;if ( Persistent() ) {
 ;   Persistent( false )
;}

;Sleep( 10000 )
;;Persistent( false )

Esc::ExitApp()

SelectorScreen( msgButtom ) {
    return MouseSelectorAxisX( msgButtom )
}

OffHook( * ) {
    
    Critical()

    global HookOff, Positriggers, _Hook, myInstallHook

    ;OutputDebug( "off - " HookOff )

    if ( HookOff ) {            
        OutputDebug( "S - " HookOff )
        Sleep( 100 )
        ;UnhookWindowsHookEx( myInstallHook.HandleHook )
        HookUn( myInstallHook )
        ToolTip()
        SetTimer( OffHook, 0 )
        if ( Persistent() ) {
            Persistent()
        }
    }
    return
}

OffSetTimer() {
    SetTimer( OffHook, 0 )
}

MouseSelectorAxisX( msgButtom ) {


    global HookOff, Positriggers, _Hook, myInstallHook

    CallBackID       := HookCallbackTo( Callback )
    IdHookID         := IdHook2( WH_MOUSE_LL() )
    myInstallHook   := HookInstall( IdHookID, CallBackID )
    
    while ( IsOut == NumericValues.Ref  ) {
        Sleep( 10 )
    }

    return myAxis.ToString()

    
    Callback1( nCode, wParam, lParam ) {

        global myAxis, Positriggers, HookOff

        static PassNext := [
            A_wParam := 0,
            A_lParam := 0
        ]       

        SetTimer( OffHook.Bind( HookOff, Positriggers, _Hook, myInstallHook ), -1 )

        ToolTip( wParam ? wParam : "Not event" )        

        if ( wParam == WM_MOUSEMOVE ) {
            A_wParam := wParam
            A_lParam := lParam
        }

        if ( ( nCode >= 0 ) and ( ( wParam == msgButtom.Value ) or ( wParam ==  msgButtom.Opposite ) ) ) {

            if ( wParam == msgButtom.Value and !HookOff ) {
                OutputDebug( "wParam - " wParam )
                myAxis := NumericValues(
                    NumGet( lParam , 0, "Int" ),
                    "Int",
                    "AxisX"
                )
            
                return 1
            }

            if ( wParam ==  msgButtom.Opposite and !HookOff ) {

                OutputDebug( "wParam - " wParam )
                HookOff := true
                return 1  ; CallNextHookEx( nCode, PassNext* )

            }
        }        

        return HookCallNext( nCode, wParam, lParam )
    }

    Callback( nCode, wParam, lParam ) {

        global myAxis, Positriggers, HookOff

        SetTimer( OffHook.Bind( HookOff, Positriggers, _Hook, myInstallHook ), -1 )

        ToolTip( wParam ? wParam : "Not event" )        
        
        if ( nCode >= 0 ) { ;and ( ( wParam == msgButtom.Value ) or ( wParam ==  msgButtom.Opposite ) ) ) {
            return                                                                                                                                          _Func( wParam, lParam )
        }        

        return HookCallNext( nCode, wParam, lParam )

        _Func( wParam, lParam ) {

            if ( wParam == msgButtom.Value and !HookOff ) {
                OutputDebug( "wParam - " wParam )
                myAxis := NumericValues(
                    NumGet( lParam , 0, "Int" ),
                    "Int",
                    "AxisX"
                )
                
                return 1
            }

            if ( wParam ==  msgButtom.Opposite and !HookOff ) {

                OutputDebug( "wParam - " wParam )
                HookOff := true
                return 1  ; CallNextHookEx( nCode, PassNext* )

            }
        }
    }
}


;{ Comentário
/*
A razão pela qual as hotkeys `#x::` e `Esc::` não funcionam neste script AutoHotkey V2 é que **o fluxo principal do script está bloqueando a thread principal**, impedindo que o interpretador processe eventos de teclado normalmente, como hotkeys.

## Causa técnica

A função `MouseSelectorAxisX()` é chamada diretamente na thread principal:

```ahk
_axis := SelectorScreen()
```

O que, por sua vez, executa o loop:

```ahk
while ( Positriggers == 1 ) {
    Sleep( 10 )
}
```

Esse loop é **bloqueante e contínuo**, mantendo a thread principal ocupada indefinidamente **até que `Positriggers` mude**. Enquanto a thread principal estiver nesse estado, nenhuma hotkey definida fora desse contexto será processada, pois AutoHotkey só avalia hotkeys entre execuções (quando está ocioso).

---

## Soluções possíveis

### 1. **Mover `MouseSelectorAxisX()` para uma thread separada**

Execute a função de seleção do mouse em uma `Thread` temporária usando `SetTimer`, `Hotkey`, `MsgBox`, ou outra forma indireta que permita a thread principal retornar:

```ahk
SetTimer SelectorScreen, -10
return
```

### 2. **Usar `Hotkey` como interrupção externa**

Transforme o controle por hotkey em uma variável observável ou interrupção ativa:

* Declare `#HotIf` para ativar dinamicamente hotkeys em determinado contexto.
* Ou use `InputHook` para capturar teclas ativamente em vez de hotkeys.

### 3. **Evitar o loop bloqueante**

Se for possível, reestruture para não depender de `while ( Positriggers == 1 )`, por exemplo:

* Reagir a eventos em vez de aguardar mudança de variável.
* Usar um mecanismo assíncrono (como `OnMessage`, `SetTimer`, ou até `Hook + Callback` em separado).

---

## Resumo técnico

| Situação                    | Efeito Observado                                  |
| --------------------------- | ------------------------------------------------- |
| `while` contínuo na thread  | Bloqueia hotkeys                                  |
| Hotkeys `#x::` e `Esc::`    | Nunca são processadas                             |
| Hook instalado corretamente | Sim, mas sem chance de escape                     |
| Solução recomendada         | Execução assíncrona ou reestruturação do controle |

Se desejar, posso reestruturar seu código para funcionar com `Hotkey` funcionando e `Hook` sendo encerrado corretamente. Deseja esse ajuste?

*/
;}


/*

Callback( Obj, nCode, wParam, lParam ) {

    Critical

    if ( !nCode and ( wParam == Obj.MsgButton.Value ) ) {

        Obj.X := NumGet( lParam , 0, "Int" )
        Obj.Y := NumGet( lParam , 4, "Int" )
        Obj.ToString := Obj.MsgButton.ToString "`nPosX := " Obj.X "`nPosY := " Obj.Y
        ToolTip( Obj.MsgButton.ToString "`nPosX := " Obj.X "`nPosY := " Obj.Y )
    }
    else if ( !nCode ) {
        ToolTip( "nPosX := " NumGet( lParam , 0, "Int" ) "`nPosY := " NumGet( lParam , 4, "Int" ) )
    }

    return CallNextHookEx( nCode, wParam, lParam )
}

/**
 * --
 * Espera e obtém informações do Mouse ao pressionar botão direito
 * --
 * --
 * Usa, para isso, HookProcesure
 * --
 * /
class ButtonDownWait {
    ;static Action := this.Call( this.MsgButtton )

    static Call( _buttonMensage, _callBack ) {

        this.MsgButtton := _buttonMensage

        Obj := {}

        Obj.DefineProp( "CallBack", { Value: _callBack } )

        _func   := ObjBindMethod( Obj, "CallBack" )        
        Address := CallbackCreate( _func, "F", 3 )

        Obj.DefineProp( "Address"   , { Value: Address } )
        Obj.DefineProp( "MsgButton" , { Value: this.MsgButtton } )
        Obj.DefineProp( "Release"   , { Call: Release } )

        this.IdHook         := IdHook( WH_MOUSE_LL() )
        this.Hook           := Hook( this.IdHook, Obj )
        this.myInstallHook  := InstallHook( this.Hook )

        Waiting := Obj.HasOwnProp( "X" )
        
        while !Waiting {
            Waiting := Obj.HasOwnProp( "X" )
        }

        Obj.Release()

        return Obj


        Callback( Obj, nCode, wParam, lParam ) {
            Critical
            _callBack()
        }


        Release( _ ) {
            Critical
            ToolTip()
            if ( _.Address ) {
                CallbackFree( _.Address )
                _.Address := 0
                UnhookWindowsHookEx( this.myInstallHook.HandleHook )
            }
        }
    }

}