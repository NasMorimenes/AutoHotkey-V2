#Include Lib.ahk
#Include ..\HookProcs\Lib\lib.ahk

myConfig := HookConfig( 14, CallbackCreate( ObjBindMethod( WaitMsgLBunttonDownB0, "Call" ), "F", 3 ) )
myIstall := HookInstall( myConfig )

Sleep( 15000 )



Esc::ExitApp()

;HookUn( myIstall )

