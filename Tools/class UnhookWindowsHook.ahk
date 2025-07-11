
class UnhookWindowsHook {

    static Call( _SetWindowsHook ) {

        Bool :=
        DllCall(
            "UnhookWindowsHookEx",
            "Uint", _SetWindowsHook.HookHandle,
            "int"
        )

        if ( bool ) {
            _SetWindowsHook.Status := false
        }
    }
}