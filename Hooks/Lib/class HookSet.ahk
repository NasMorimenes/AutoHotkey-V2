

/**
 * --
 * Instala um Hook Procedure
 * --
 */
class HookSet {

    static Ref := 0

    static Call( IdHookID, LpFnID ) {

        IdHook := Register.Get( IdHookID )
        LpFn   := Register.Get( LpFnID )

        ++this.Ref
        ID := this.Prototype.__Class "_" this.Ref

        HHandle :=
        DllCall(
            "SetWindowsHookEx",
            "int", IdHook.Value,
            "Ptr", LpFn.Address,
            "Ptr", 0,
            "UInt", 0,
            "Ptr"
        )

        if ( HHandle ) {

            return Register(
                {
                    IDHook  : IdHookID,
                    LpFn    : LpFnID,
                    HHandle : HHandle,
                    ID      : ID
                }
            )
        }
    }
}