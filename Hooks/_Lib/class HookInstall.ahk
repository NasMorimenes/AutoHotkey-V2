class HookInstall {

	static Call( _HookConfig ) {

		_Hook := ObjFromKeyRegistration( _HookConfig )

		_Hook.HandleHook :=
		DllCall(
			"SetWindowsHookExW",
			"Int", _Hook.IdHook,
			"Ptr", _Hook.lpfn,
			"Ptr", 0,
			"UInt", 0,
			"Ptr"
		)

		if ( _Hook.HandleHook ) {
			_Hook.Status := true
			return _HookConfig
		}
	}
}