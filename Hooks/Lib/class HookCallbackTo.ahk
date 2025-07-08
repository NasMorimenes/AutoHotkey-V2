
/**
 * 
 * @example
;LpFn structure
Lpfn  := {
    Address : CallbackCreate( _func, "F", 3 ),
    ID      : ID,
    Block   : false,
    Release : ReleaseLpFn
}
ReleaseLpFn( _ ) {

    if ( _.Address ) {
        
        CallbackFree( _.Address )
        _.Address := 0
        OutputDebug( "Is Release!")
        return
    }
}
 */
class HookCallbackTo {
    
    static Ref := 0
    static Register := Map()

    static Call( _func, NumParams := 3, params* ) {

        NumParams := ( NumParams + params.Length )
        
        ++this.Ref
        ID := this.Prototype.__Class "_" this.Ref

        this.Register.Set( ID,
            {
                Address  : CallbackCreate( _func, "F", NumParams ),
                ID       : ID,
                Block    : false,
                DataType : "HookCallbackTo",
                Release  : Release
            }
        )
        
        return ID

        Release( _ ) {

            if ( _.Address ) {
                
                CallbackFree( _.Address )
                _.Address := 0
                OutputDebug( "Is Release!")
                return
            }
        }
    }
}