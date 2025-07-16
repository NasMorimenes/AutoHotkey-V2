
class WaitMsgLBunttonDownB0 extends HookProc {

    static Out := []

    static FnCallBack( wParam, lParam ) {

        lButonDown := false

        if ( wParam == WM_LBUTTONDOWN ) {
            Registrar( wLaramMouseLL( lParam ) )
            lButonDown := true
            return true
        }
        
        if ( wParam == WM_LBUTTONUP ) {
            return true
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