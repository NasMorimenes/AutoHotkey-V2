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

    static Call( _NumericValue ) {
        
        ++this.Ref
        ID := this.Prototype.__Class "_" this.Ref

        return Register( {
                Value   : _NumericValue,
                ID      : ID,
                Status  : true,
                Release : Release,
                Type    : "Ptr"
            }
        )

        Release( _ ) {
            HookUn( _ )
        }
    }
}