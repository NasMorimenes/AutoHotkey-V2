

class HookUn {

    static Call( _SetWindows ) {
        OutputDebug( "p8")
		_SetWindowsHook := ObjFromKeyRegistration( _SetWindows )
        Bool :=
        DllCall(
            "UnhookWindowsHookEx",
            "Uint", _SetWindowsHook.HandleHook,
            "int"
        )

        if ( bool ) {
            _SetWindowsHook.Status := false
        }
    }
}