class HookInstall {

	static Call( _HookConfig ) {
		
		HandleHook :=
		DllCall(
			"SetWindowsHookExW",
			"Int", _HookConfig.IdHook,
			"Ptr", _HookConfig.lpfn,
			"Ptr", 0,
			"UInt", 0,
			"Ptr"
		)

		if ( HandleHook ) {
			Status := true

			Out := {
				DataType    : "HookInstallSet",
				IdHook		: _HookConfig.IdHook,
				LpFn		: _HookConfig.LpFn,
				HandleHook	: HandleHook,
				Status		: Status,
				Release		: _HookConfig.Release,
				__Delete	: Delete,
			}

			return Out

			Delete( _ ) {
				OutputDebug( "p71")
				HookUn( _ )
			}
		}
	}
}