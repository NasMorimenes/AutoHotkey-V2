
class UnhookWindowsHook {

    static Call( _ ) {
        
        Bool :=
        DllCall(
            "UnhookWindowsHookEx",
            "Uint", _.HookHandle,
            "int"
        )

        if ( bool ) {
            _.Status := false
        }
    }
}