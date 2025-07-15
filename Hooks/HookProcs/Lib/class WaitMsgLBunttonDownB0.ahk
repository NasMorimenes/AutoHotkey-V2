
class WaitMsgLBunttonDownB0 extends HookProc {

    static FnCallBack( wParam, lParam ) {

        lButonDown := false

        if ( wParam == WM_LBUTTONDOWN ) {
            wParamMouseLL( wParam )
            lButonDown := true
            return true
        }
        
        if ( wParam == WM_LBUTTONUP ) {
            wParamMouseLL( wParam )
            return true
        }

        return false
    }
}

class wLaramMouseLL {
    static Call( lParam ) {
        this.X := NumGet( lParam, 0, "UInt" )        
        this.Y := NumGet( lParam, 4, "UInt" )
    }
}