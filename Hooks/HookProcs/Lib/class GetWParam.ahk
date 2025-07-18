

class GetWParam extends HookProc {
    static Status       := false
    static InstalHook   := 0
    static Call( nCode, wParam, lParam, installHook := false ) {

        if ( installHook ) {
            this.IdHook     := 14
            ;this.CallBack   := ObjBindMethod( HookProc, "Call" )
            ;this.Address    := CallbackCreate( this.CallBack, "F", 3 )
            this.Address    := CallbackCreate( super.Call, "F", 3 )
            this.InstalHook := HookInstallSet( 14, this.Address )
            
            if ( WaitUntil( this, "WParam", wParam, "HookOff" ) ) {
                return [
                    this.WParam,
                    this.LParam
                ]
            }
        }
        else {
            super.Call( ncode, wParam, lParam )
        }
    }

    static FnCallBack( wParam, lParam ) {
        this.WParam := wParam
        this.LParam := lParam
        this.Status := true
        return false
    }

    static HookOff(_installHook := 0 ) {
        if ( _installHook ) {
            HookUn( _installHook )
            return
        }
        HookUn( this.InstalHook )
    }
}