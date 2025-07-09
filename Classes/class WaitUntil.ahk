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
        ToolTip( nTin )
        if ( nTin >= this.Timer and ( !this.Timer ? false : true ) ) {
            this.TimeOut := true
        }

    }
}