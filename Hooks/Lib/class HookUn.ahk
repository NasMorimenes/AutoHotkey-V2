

class HookUn {

    static Call( _HookInstall ) {

        if ( _HookInstall.Hook.Value ) {

            OutputDebug( "Hook Off ")
            bool :=
            DllCall(
                "UnhookWindowsHookEx",
                "Uint", _HookInstall.Hook.Value,
                "int"
            )
            _HookInstall.Hook.Value := 0
            _HookInstall.HookConfig.Release()
            _HookInstall.Status := false
            return bool
        }
    }

}