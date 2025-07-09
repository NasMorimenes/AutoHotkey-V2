

/**
 * 
 * @example
#Include F:\OneDrive Local\OneDrive\2025 06 25 Autohotkey V2\000.04.05.2025.PPN\ppn\SendPrePostagem\_Implementações\Hook\InstallHook\Lib\Lib.ahk
_IdHook := IdHook( WH_MOUSE_LL() )
_LpFn   := 

; */
class HookInstall {

    __New( IdHookID, LpFnID ) {

        this.HookHandleID  := 0
        this.IdHookID      := IdHookID
        this.LpFnID        := LpFnID        
        this.HookSetID     := HookSet( this.IdHookID, this.LpFnID )
    }

    IdHook {
        get {
            return Register.Get( this.IdHookID )
        }
    }

    LpFn {
        get {
            return Register.Get( this.LpFnID )
        }
    }

    __Delete() {
        _HookHandle := Register.Get( this.HookHandleID )
        _HookHandle.Release()
    }
}