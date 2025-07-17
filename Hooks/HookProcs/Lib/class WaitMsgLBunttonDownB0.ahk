
class WaitMsgLBunttonDownB0 extends HookProc {

    static Out := []

    static FnCallBack( wParam, lParam ) {

        static lButonDown := false

        if ( !lButonDown and ( wParam == WM_LBUTTONDOWN or wParam == WM_LBUTTONUP ) ) {
            if ( wParam == WM_LBUTTONDOWN ) {
                Registrar( wLaramMouseLL( lParam ) )
                lButonDown := true
                return true
            }

            if ( wParam == WM_LBUTTONUP and lButonDown ) {
                Registrar( wLaramMouseLL( lParam ) )                
                return true
            }
        }
        return false
    }
}

class wLaramMouseLL {
    
    static Call( lParam ) {

        this.X := NumGet( lParam, 0, "UInt" )        
        this.Y := NumGet( lParam, 4, "UInt" )

        return {
            X : this.X,
            Y : this.Y
        }
    }
}