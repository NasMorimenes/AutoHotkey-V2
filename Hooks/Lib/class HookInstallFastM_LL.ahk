#Include lib.ahk

UserCall := UserHookCallbackTo( _func )

idFastM_LL := HookInstallFastM_LL( UserCall )

/**
 * 
 * @param _      Objeto que receberá _func como um método
 * @param wParam 
 * @param lParam 
 */
_func( _, wParam, lParam ) {
	;OutputDebug( _.DataType ) --> UserHookCallbackTo
	ToolTip( "wParam - " wParam)
	( wParam == WM_LBUTTONUP and _.Block := true )
	( wParam == WM_LBUTTONDOWN and _.Block := true )
	( wParam == WM_MOUSEMOVE and _.Block := false )

	if ( wParam == 522 ) {
		HookInstallFastM_LL.__Delete()
	}
}

Esc::{
	HookInstallFastM_LL.__Delete()
	ExitApp()
}

/**

;LpFn structure
_func( wParam, lParam ) {
	...
}


Ass.DataType := "UserHookCallbackTo"
Ass() {
	return 1
}
MsgBox Ass.DataType



NumArgs := 2
Lpfn  := {
	Address : CallbackCreate( _func, "F", NumArgs ),
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
class HookInstallFastM_LL {

	static Ref := 0
	static Register := Map()

	static Call( _UserHookCallbackTo := "" ) {

		++this.Ref
		ID := this.Prototype.__Class "_" this.Ref

		if ( Type( _UserHookCallbackTo.Value ) == "Func" and _UserHookCallbackTo.DataType == "UserHookCallbackTo" ) {

			this._UserHookCallbackTo := _UserHookCallbackTo
		}
		else {
			Text := "Defina a Função a ser executada"
			this._UserHookCallbackTo := ( this, wParam, lParam ) => ToolTip( this.Ref "`n" Text "`n" wParam "`n" lParam )
		}

		this.LpFn               := ObjBindMethod( this, "CallBack" )
		this.CallBackID         := HookCallbackTo( this.LpFn )
		this.IdHookID           := IdHook( WH_MOUSE_LL() )
		this.myInstallHook      := HookInstall( this.IdHookID, this.CallBackID )

		this.Register.Set( ID, 
			{
				InstallHook	: this.myInstallHook,
				ID 			: ID,
				DataType	: "HookInstallFastM_LL"
			}
		)

		return this.Register[ ID ]
	}

	static CallBack( nCode, wParam, lParam ) {

		if ( nCode >= 0 ) {

			this._UserHookCallbackTo.Value( wParam, lParam )

			if ( this._UserHookCallbackTo.Block ) {
				return 1
			}
		}

		return HookCallNext( nCode, wParam, lParam )
	}

	static __Delete() {
		HookUn( this.myInstallHook  )
	}
}