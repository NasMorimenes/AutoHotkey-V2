#Include Lib.ahk
#Include ..\HookProcs\class MsgView.ahk
myConfig := HookConfig( 14, CallbackCreate( ObjBindMethod( MsgView, "Call" ), "F", 3 ) )
myIstall := HookInstall( myConfig )
Sleep( 5000 )
;HookUn( myIstall )
Persistent()