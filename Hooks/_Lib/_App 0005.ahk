#Include Lib.ahk
#Include ..\HookProcs\Lib\lib.ahk

Sleep( 5000 )
myIstall := HookInstallSet( 14, CallbackCreate( ObjBindMethod( GetWParam, "Call" ), "F", 3 ) )
;GetWParam.InstallHook := myIstall
if ( WaitUntil( GetWParam, "Status", true) ) {
    MsgBox( GetWParam.WParam )
    HookUn( myIstall )
}


