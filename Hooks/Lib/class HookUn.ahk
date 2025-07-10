

class HookUn {

    static Call( _HookID ) {
        ;HookHandle := _HookID.HookHandle ;Register.Get( HookHandleID )

        if ( _HookID.Status ) {

            OutputDebug( "Hook Off " this.__Class )
            bool :=
            DllCall(
                "UnhookWindowsHookEx",
                "Uint", _HookID.HookHandle,
                "int"
            )

            if ( bool ) {
                _HookID.HookHandle := 0
                _HookID.Status := false
                return bool
            }
            
           
        }
    }

}