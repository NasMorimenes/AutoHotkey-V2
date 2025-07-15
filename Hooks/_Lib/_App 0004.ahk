#Include Lib.ahk
#Include ..\HookProcs\Lib\lib.ahk
myIstall := HookInstallSet( 14, CallbackCreate( ObjBindMethod( MsgView, "Call" ), "F", 3 ) )

Sleep( 5000 )

HookUn( myIstall )