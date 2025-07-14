class HookInstallSet extends Registrar {

	static Call( idHook, lpfn ) {

		this.IdHook := idHook
		this.LpFn   := lpfn
		++this.Ref

		super.Call()

		ID := this.Prototype.__Class "_" this.Ref
		this.ID := ID

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

			this.Registration[ ID ].ID			:= this.ID
        	this.Registration[ ID ].DataType    := "HookInstallSet"
			this.Registration[ ID ].IdHook		:= this.IdHook
			this.Registration[ ID ].LpFn		:= this.LpFn
			this.Registration[ ID ].HandleHook	:= this.HandleHook
			this.Registration[ ID ].Status		:= this.Status
			this.Registration[ ID ].Release		:= this.Release
			this.Registration[ ID ].__Delete	:= Delete

			return {
				ID			: ID,
				DataType 	: "ObjKeyRegistration"
			}

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