
class HookInstallSet {

	static Call( idHook, lpfn ) {

		this.IdHook := idHook
		this.LpFn   := lpfn
		
		this.HandleHook :=
		DllCall(
			"SetWindowsHookExW",
			"Int", IdHook,
			"Ptr", lpfn,
			"Ptr", 0,
			"UInt", 0,
			"Ptr"
		)

		if ( this.HandleHook ) {

			this.Status := true

			Out := {
				DataType    : "HookInstallSet",
				IdHook		: this.IdHook,
				LpFn		: this.LpFn,
				HandleHook	: this.HandleHook,
				Status		: this.Status,
				Release		: this.Release,
				__Delete	: Delete,
			}

			return Out

			Delete( _ ) {
				OutputDebug( "p7")
				HookUn( _ )
			}
		}
	}

	static Release() {
		OutputDebug( "p6" )
		if ( this.LpFn.Address ) {
			this.LpFn.Release()
			this.LpFn.Address := 0
		}
	}

	static __Delete() {
		OutputDebug( "p7")
		HookUn( this )
	}
}