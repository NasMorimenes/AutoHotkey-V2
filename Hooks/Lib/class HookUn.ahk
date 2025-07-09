

class HookUn {

    static Call( HookHandleID ) {
        HookHandle := Register.Get( HookHandleID )

        if ( HookHandle.Status ) {

            OutputDebug( "Hook Off ")
            bool :=
            DllCall(
                "UnhookWindowsHookEx",
                "Uint", HookHandle.Value,
                "int"
            )

            if ( bool ) {
                HookHandle.Value := 0
                HookHandle.Status := false
                return bool
            }
            
           
        }
    }

}