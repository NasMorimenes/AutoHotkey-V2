

/**
 * --
 * Instala um Hook Procedure
 * --
 */
class HookSet {

    static Ref := 0
    static Register := Map()

    static Call( _HookConfig ) {

        ++this.Ref
        ID := this.Prototype.__Class "_" this.Ref

        HandlehHook :=
        DllCall(
            "SetWindowsHookEx",
            "int", _HookConfig.IdHook,
            "Ptr", _HookConfig.Address,
            "Ptr", _HookConfig.HMod,
            "UInt", 0,
            "Ptr"
        )
        
        hHook := HookHandle( HandlehHook )

        this.Register.Set( ID,
            {
                Value       : hHook.Value,
                ID          : ID,
                Status      : hHook.Status,
                IdHook      : _HookConfig.IdHook,
                Address     : _HookConfig.Address
            }
        )
        
        return this.Register[ ID ]
    }
}