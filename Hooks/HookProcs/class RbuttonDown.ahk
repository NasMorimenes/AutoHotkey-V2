class RButtonDown {
    
    static Call() {

		Out := {}
		Out.Value     := WM_RBUTTONDOWN
        Out.Opposite  := RButtonUp()
		Out.Type      := "MsgButton"
        Out.Button    := "RButton"
		Out.ToString  := "RButton Pressionado"

		Out.DefineProp( "Status", { Get : GetStatus } )
		Out.DefineProp( "WParam", { Get : GetWParam })

		return Out

		GetStatus( _ ) {
			
			if ( _.WParam == _.Value ) {

				;_.X := NumGet( _.LParam, 0, "UInt" )
				;_.Y := NumGet( _.LParam, 4, "UInt" )

				return true
			}

			return false
		}

		GetWParam( _, nCode, wParam, lParam ) {

            CallBack := MsgView( nCode, wParam, lParam )

			Address := CallbackCreate( CallBack, "F" )
			
			_.HookConfig := HookConfig( 14, Address )
			_.HookInstall := HookInstall( _.HookConfig )

			CallBack1( nCode, wParam, lParam ) {
				if ( nCode >= 0 ) {
					WaitUntil( _, "Status", true, "ExiHook")
				}			
			}
		}

		ExitHook( _ ) {
			HookUn( _.HookInstall )
		}

	}
}