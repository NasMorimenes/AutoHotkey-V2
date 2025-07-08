/**
 * Define um objeto o Tipo handleHook - indentificador para
 * o Hook Procedure
 * 
 * @example
HookHandle := {
    Value : _NumericValue,
    Status: true,
    Type  : "Ptr"
}
 */
class HookHandle {

    static Ref := 0
    static Register := Map()

    static Call( _NumericValue ) {
        
        ++this.Ref
        ID := this.Prototype.__Class "_" this.Ref

        this.Register.Set( ID,
            {
                Value   : _NumericValue,
                ID      : ID,
                Status  : true,
                Type    : "Ptr"
            }
        )

        return this.Register[ ID ]
    }
}