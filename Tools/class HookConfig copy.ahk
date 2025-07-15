

class HookConfig extends Registrar {

    static Call( idHook, lpfn ) {

		this.IdHook := idHook
		this.LpFn   := lpfn
		++this.Ref

		super.Call()

		ID := this.Prototype.__Class "_" this.Ref

		this.ID := ID
        this.Registration[ ID ].ID			:= this.ID
		this.Registration[ ID ].IdHook		:= this.IdHook
		this.Registration[ ID ].LpFn		:= this.LpFn
        this.Registration[ ID ].DataType    := "HookConfig"
		this.Registration[ ID ].Release     := this.Release
		this.Registration[ ID ].__Delete    := this.__Delete

        return {
			ID			: ID,
			DataType 	: "ObjKeyRegistration"
		}
    }

    static Release() {
		if ( this.LpFn.Address ) {
			this.LpFn.Release()
			this.LpFn.Address := 0
		}
	}    

	static __Delete() {
		HookUn( this )
	}
		
}