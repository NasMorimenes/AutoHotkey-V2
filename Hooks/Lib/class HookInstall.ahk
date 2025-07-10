

/**
 * 
 * @example
#Include F:\OneDrive Local\OneDrive\2025 06 25 Autohotkey V2\000.04.05.2025.PPN\ppn\SendPrePostagem\_Implementações\Hook\InstallHook\Lib\Lib.ahk
_IdHook := IdHook( WH_MOUSE_LL() )
_LpFn   := 

; */
class HookInstall {

    __New( _ ) {

        this.HookHandle    := 0
        this.Status        := _.Status
        this.IdHookID      := _.IdHookID
        this.LpFn          := _.Address
        OutputDebug( this.LpFn )
        this.HookSetID     := HookSet( this )
    }

    IdHook {
        get {
            return Register.Get( this.IdHookID )
        }
    }

    Release() {

		if ( this.LpFn ) {     
			CallbackFree( this.LpFn )
			this.LpFn := 0
			OutputDebug( "Is Release! " this.__Class )
			return
		}
	}

    __Delete() {
        this.Release()
    }
}