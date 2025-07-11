
class CoordinateMouseSelector {

	static Call( _MsgButton ) {

		CallBack( _In, nCode, wParam, lParam, _Out ) {

			if ( nCode >= 0 and wParam == _In.MsgButton.Value ) {

				Out.Out := [
					NumGet( lParam, 0, "Int" ),
					NumGet( lParam, 4, "Int" )
				]
				Out.IsOut := true
				OutputDebug( "Properties true!")
			}

			if ( Out.Block ) {
				return 1
			}

			return HookCallNext( nCode, wParam, lParam )
		}
	}
}


_MsgButton := {
	Value     : WM_LBUTTONDOWN,
	Type      : "MouseMensage",
	Button    : "LButton",
	ToString  : "LButton Pressionado"
}

HookInstall := {
	Call		: Fun,
	HookHandle	: 0,
	MsgButton	: WM_LBUTTONDOWN,
	Status		: CoordinateMouseSelector.Status,
	IdHookID	: CoordinateMouseSelector.IdHookID,
	LpFn		: CoordinateMouseSelector.Address,
	HookSetID	: {
		IDHook  	: HookInstall.IdHookID,
		LpFn    	: HookInstall.LpFn,
		HHandle 	: HookInstall.HookHandle,
		ID      	: ID,
		Status  	: HookInstall.Status
	}
	Callback	: Fun
}

HookSet := {
	Ref		:
}

Anomin2 := {
	IDHook  : HookInstall.IdHookID,
	LpFn    : HookInstall.LpFn,
	HHandle : HookInstall.HookHandle,
	ID      : ID,
	Status  : HookInstall.Status
}

CoordinateMouseSelector := {

	Ref			:0,

	MsgButton	: {
		Value     : WM_LBUTTONDOWN,
		Type      : "MouseMensage",
		Button    : "LButton",
		ToString  : "LButton Pressionado"
	},

	Block		: false,
	Status		: false,

	LpFn		: ObjBindMethod( CoordinateMouseSelector, "CallBack",_Out ),
	Address		: CoordinateMouseSelector.LpFn,

	IdHookID	:{

		Value        : {
			Value    : 4,
			Type     : "Int"
		},

		ID        : ID,
		DataType  : "NumericValues"
	},

	HookID		: {
		HookHandle	: 0,
		Status		: CoordinateMouseSelector.Status,
		IdHookID	: CoordinateMouseSelector.IdHookID,
		LpFn		: CoordinateMouseSelector.Address,
		HookSetID	: {
			IDHook  : HookInstall.IdHookID,
			LpFn    : HookInstall.LpFn,
			HHandle : HookInstall.HookHandle,
			ID      : ID,
			Status  : HookInstall.Status
		}
	},
}

Out := {
	IsOut		: false,
	Block		: false,
	HookID		: {
		HookHandle	: 0,
		Status		: CoordinateMouseSelector.Status,
		IdHookID	: CoordinateMouseSelector.IdHookID,
		LpFn		: CoordinateMouseSelector.Address,
		HookSetID	: {
			IDHook  : HookInstall.IdHookID,
			LpFn    : HookInstall.LpFn,
			HHandle : HookInstall.HookHandle,
			ID      : ID,
			Status  : HookInstall.Status
		}
	End
}

_MsgButton := {
	Value     : WM_LBUTTONDOWN,
	Type      : "MouseMensage",
	Button    : "LButton",
	ToString  : "LButton Pressionado"
}

WH_MOUSE_LL := {
	Value : 4,
	Type  : "Int"
}

IdHook := {
	Value     : _value.Value,
	ID        : ID,
	DataType  : "NumericValues"
}