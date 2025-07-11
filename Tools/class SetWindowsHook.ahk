
myIstall := SetWindowsHook( 14, CallbackCreate( ObjBindMethod( View, "Call" ), "F", 3 ) )

Sleep( 10000 )

UnhookWindowsHook( myIstall )

class View {
	static Call( nCode, wParam, lParam ) {

		ToolTip( wParam )

		return HookCallNext( nCode, wParam, lParam )
	}
}

class HookCallNext {

    static Call( nCode, wParam, lParam ) {

        LRESULT :=
        DllCall(
            "CallNextHookEx",
            "Uint", 0,
            "int", nCode,
            "Uint", wParam,
            "Uint", lParam
        )

        return {
            Value: LRESULT
        }
    }
}

class SetWindowsHook extends Registrar {

	static Call( idHook, lpfn ) {

		this.IdHook := idHook
		this.LpFn   := lpfn

		super.Call()
		++this.Ref
		ID := this.Prototype.__Class "_" this.Ref
		
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
			this.Registration[ ID ].IdHook		:= this.IdHook
			this.Registration[ ID ].LpFn		:= this.LpFn
			this.Registration[ ID ].HandleHook	:= this.HandleHook
			this.Registration[ ID ].Status		:= this.Status
			this.Registration[ ID ].Release		:= this.Release
			this.Registration[ ID ].__Delete	:= this.__Delete

			return {
				ID			: ID,
				DataType 	: "ObjFromKeyRegistration"
			}
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

class UnhookWindowsHook {

    static Call( _SetWindows ) {
		_SetWindowsHook := ObjFromKeyRegistration( _SetWindows )
        Bool :=
        DllCall(
            "UnhookWindowsHookEx",
            "Uint", _SetWindowsHook.HookHandle,
            "int"
        )

        if ( bool ) {
            _SetWindowsHook.Status := false
        }
    }
}

/*
	Ass := Cases()

	myKey := ObjKeyRegistration( Ass )

	myObj := ObjFromKeyRegistration( myKey )

	MsgBox( myObj.Case )
*/
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

class ObjKeyRegistration {

	static Call( _ ) {
		if ( _.HasProp( "ID" ) ) {

			return {
				ID 			: _.ID,
				DataType 	: "ObjKeyRegistration"
			}
		}
	}
}

class ObjFromKeyRegistration {

	static Call( _ObjKeyRegistration ) {
		if ( _ObjKeyRegistration.DataType == "ObjKeyRegistration" ) {
			return Registrar.Registration[ _ObjKeyRegistration.ID ]
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

		return {
			ID			: ID,
			DataType 	: "ObjFromKeyRegistration"
		}
	}

	static __Delete() {
		if ( this.Case == "Food" ) {
			Cases.Case := ""
		}
	}
}