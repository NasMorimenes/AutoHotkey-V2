#Include ..\..\Tools\class Registrar.ahk
#Include Lib.ahk


class HookInstallSetS {

	__New( idHook, lpfn ) {

		this.IdHook := idHook
		this.LpFn   := lpfn
		this.DataType := "HookInstallSet"

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
			ID := Registrar( this )

			return {
				ID			: ID,
				DataType 	: "ObjKeyRegistration"
			}
		}
	}

	Release() {
		OutputDebug( "p6" )
		if ( this.LpFn.Address ) {
			this.LpFn.Release()
			this.LpFn.Address := 0
		}
	}

	__Delete() {
		OutputDebug( "p7")
		HookUn( this )
	}
}