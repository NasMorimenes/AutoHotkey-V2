
/*
class SetWindowsHook {

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
		}

		return {
			IdHook		: this.IdHook,
			LpFn		: this.LpFn,
			HandleHook	: this.HandleHook,
			Status		: this.Status,
			Release		: ( _ ) => this.Release,
			__Delete	: this.__Delete
		}
	}

	static Release() {
		if ( this.LpFn.Address ) {
			this.LpFn.Release()
			this.LpFn.Address := 0
		}
	}

	static __Delete() {
		UnhookWindowsHook( this )
	}
}
*/


Ass := Cases()
MsgBox( Registrar.Registration[ Ass ].Case )
Registrar.Registration[ Ass ].Case := "Food"

class Registrar  {

	static Registration := Map()
	static Ref := 0

	static Call() {
		Out := {}
		Out.Ref := this.Ref
		Out.ID := this.Prototype.__Class "_" this.Ref

		if ( !this.Registration.Has( Out.ID ) ) {
			this.Registration.Set(
				Out.ID,
				Out
			)
		}

	}
}

class Cases extends Registrar {
	
	static Call() {
		++this.Ref
		this.Case := "good"
		super.Call()
		ID := this.Prototype.__Class "_" this.Ref

		this.Registration[ ID ].Case := this.Case
		this.Registration[ ID ].__Delete := this.__Delete
		return ID
	}

	static __Delete() {
		if ( this.Case == "Food" ) {
			Cases.Case := ""
		}
	}
}