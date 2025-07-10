

/**
 * --
 * Instala um Hook Procedure
 * --
 */
class HookSet {

    static Ref := 0

    static Call( _ ) {

        IdHook := Register.Get( _.IdHookID )

        ++this.Ref
        ID := this.Prototype.__Class "_" this.Ref

        _.HookHandle :=
        DllCall(
            "SetWindowsHookEx",
            "int", IdHook.Value,
            "Ptr", _.LpFn,
            "Ptr", 0,
            "UInt", 0,
            "Ptr"
        )

        if ( _.HookHandle ) {

            _.Status := true

            return Register(
                {
                    IDHook  : _.IdHookID,
                    LpFn    : _.LpFn,
                    HHandle : _.HookHandle,
                    ID      : ID,
                    Status  : _.Status
                }
            )
        }
    }
}