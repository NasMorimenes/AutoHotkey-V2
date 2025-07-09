

/**
 * --
 * Instala um Hook Procedure
 * --
 */
class HookSet {

    static Ref := 0

    static Call( _ ) {

        ++this.Ref
        ID := this.Prototype.__Class "_" this.Ref

        HandlehHook :=
        DllCall(
            "SetWindowsHookEx",
            "int", _.IdHook.Value,
            "Ptr", _.LpFn.Address,
            "Ptr", 0,
            "UInt", 0,
            "Ptr"
        )
        _.HookHandleID := HookHandle( HandlehHook )
        return Register( {
                Hook : _,
                ID   : ID
            }
        )
    }
}