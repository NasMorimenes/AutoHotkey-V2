#Include ..\..\_Lib\class HookCallNext.ahk

class HookProc {
    
    static DataType := "HookProc" ; ver Prototype.__Class

    static Call( nCode, wParam, lParam ) {
        static Params := [ wParam, lParam ]
        if ( nCode >= 0 ) {
            if ( this.fnCallBack( wParam, lParam ) ) {
                return 1
            }
        }

        return HookCallNext( nCode, wParam, lParam )

    }
    

    ;static CallBack := this.Call.Bind( ObjBindMethod( this, "FnCallBack" ) )

    static FnCallBack( wParam, lParam, Out* ) {
        ToolTip( "Implememte FnCallBack!")

        return false
    }

    static __Delete() {
        OutputDebug( "__Delete")
        ToolTip()
    }
}