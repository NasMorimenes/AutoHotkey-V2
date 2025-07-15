

class HookConfig {

    static Call( idHook, lpfn ) {

		this.IdHook := idHook
		this.LpFn   := lpfn

		Out := {
			IdHook		: this.IdHook,
			LpFn		: this.LpFn,
			DataType    : "HookConfig",
			Release     : this.Release,
			__Delete    : this.__Delete,
		}

        return Out
    }

    static Release() {
		if ( this.LpFn ) {
			;this.LpFn.Release()
			CallbackFree( this.LpFn )
			this.LpFn := 0
		}
	}    

	static __Delete() {

		if ( this.LpFn ) {
			this.Release()
			this.LpFn := 0
		}
	}
		
}