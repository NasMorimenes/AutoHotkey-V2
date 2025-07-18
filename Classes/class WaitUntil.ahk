/**
 * 
 * @example
Obj := {
    Casa : "Minha",
    Rua : ( _ ) =>  ( MsgBox( _.Casa " é minha casa de verão!" ) )
}

OutputDebug WaitUntil( Obj, "Casa", "Esta", "Rua", 5000 )

;MsgBox( Obj.Rua() )

Esc::ExitApp()

#x:: {
    global
    ; Atribui o valor esperado.
    Obj.Casa := "Esta"
}
 */
class WaitUntil {

    static Call( _, Prop, ValueProp, MethodCall := "", _Timer := 0 ) {

        this.Obj        := _
        this.Prop       := Prop
        this.ValueProp  := ValueProp
        this.MethodCall := MethodCall 
        this.Timer      := _Timer
        this.Changed    := false
        this.TimeOut    := false

        this.CallBack := ObjBindMethod( this, "GetTimeOut" )
        SetTimer( this.CallBack, 10 )

        return this.Consult()
    }

    static Consult( ) {
        
        MethodCalll := ( this.MethodCall ) != "" ? true : false

        while ( this.Obj.%this.Prop% != this.ValueProp and this.TimeOut == false ) {
            Sleep( 10 )
        }

        if ( this.TimeOut == true ) {
            ToolTip()
            SetTimer( this.CallBack, 0 )
            return false
        }

        if ( this.Obj.%this.Prop% == this.ValueProp ) {
            ToolTip()
            ( MethodCalll and this.Obj.%this.MethodCall%() )
            SetTimer( this.CallBack, 0 )
            return true
        }

    }

    static GetTimeOut() {

        static ti := A_TickCount
    
        nTin := A_TickCount - ti
        if ( nTin >= this.Timer and ( !this.Timer ? false : true ) ) {
            this.TimeOut := true
        }

    }
}


class WaitUntilProp {

    static Call( _PropertyWait ) {
        this.WaitProperty   := _PropertyWait.WaitProperty
        this.ExpectedValue  := _PropertyWait.ExpectedValue
        this.ToExecute      := _PropertyWait.ToExecute
    }
}

/**
 * Cria e retorna um objeto de descrição de condição de espera.
 * 
 * Este objeto contém as informações necessárias para que a classe `ConditionWaiter`
 * aguarde até que uma determinada propriedade atinja o valor esperado.
 * 
 * @param this         Referência implícita ao contexto estático (ignorada).
 * @param Property     Nome da propriedade a ser observada.
 * @param Value        Valor esperado da propriedade.
 * @param Execute      (Opcional) Função a ser executada quando a condição for satisfeita.
 * 
 * @returns {Object}   Um objeto contendo:
 *                     - PropertyName    → Nome da propriedade.
 *                     - ExpectedValue   → Valor esperado.
 *                     - Callback        → Função a ser chamada ao atingir a condição, se fornecida.
 * 
 * @remarks
 * Este objeto é interpretado e processado pela classe `ConditionWaiter`, que executa a verificação
 * periódica e invoca o callback, se fornecido.
 */

class WaitDescriptor {

    static Call( Property, Value, Execute := unset ) {

        Out := {
            PropertyName    : Property,
            ExpectedValue   : Value,
        }

        if ( IsSet( Execute ) and Type( Execute ) == "Func" ) {
            Out.Callback := Execute
        }

        return Out
    }
}