

class CallBackToHook {

    static DataType := "CallBackToHook"

    static Call( _func ) {
        return this.UserCallBack := _func
    }

    static CallBack( nCode, wParam, lParam ) {

        if ( nCode >= 0 ) {
            if ( this.UserCallBack( wParam, lParam ) ) {
                return 1
            }
        }
        
        return HookCallNext( nCode, wParam, lParam )
    }
}