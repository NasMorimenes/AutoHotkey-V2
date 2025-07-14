#Include Lib.ahk
myIstall := HookInstallSet( 14, CallbackCreate( ObjBindMethod( View, "Call" ), "F", 3 ) )

Sleep( 5000 )

HookUn( myIstall )