

/**
 * 
 * @example
#Include F:\OneDrive Local\OneDrive\2025 06 25 Autohotkey V2\000.04.05.2025.PPN\ppn\SendPrePostagem\_Implementações\Hook\InstallHook\Lib\Lib.ahk
_IdHook := IdHook( WH_MOUSE_LL() )
_LpFn   := 

; */
class HookInstall {

    __New( IdHookID, LpFnID ) {

        this.IdHookID     := IdHookID
        this.LpFnID       := LpFnID
        
        this.HookConfig := HookConfig( this.IdHook, this.LpFn )
        this.Hook       := HookSet( this.HookConfig )

    }

    IdHook {
        get {
            return IdHook.Register[ this.IdHookID ]
        }
    }

    LpFn {
        get {
            return HookCallbackTo.Register[ this.LpFnID ]
        }
    }

    __Delete() {
        OutputDebug( "Delete " Type( this) )
        HookUn( this )
    }
}