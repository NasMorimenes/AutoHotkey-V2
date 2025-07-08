

class HookCallNext {

    static Call( nCode, wParam, lParam, hHook := 0 ) {

        LRESULT :=
        DllCall(
            "CallNextHookEx",
            "Uint", hHook,
            "int", nCode,
            "Uint", wParam,
            "Uint", lParam
        )

        return {
            Value: LRESULT
        }
    }
}