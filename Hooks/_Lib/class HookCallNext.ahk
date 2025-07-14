

class HookCallNext {

    static Call( nCode, wParam, lParam ) {

        LRESULT :=
        DllCall(
            "CallNextHookEx",
            "Uint", 0,
            "Int", nCode,
            "Uint", wParam,
            "Uint", lParam,
            "Int"
        )

        return LRESULT
    }
}