#Include Lib.ahk
#Include ..\HookProcs\Lib\lib.ahk
Key :=  "wParamMouseLL"
Method := "Registration"
myConfig := HookConfig( 14, CallbackCreate( ObjBindMethod( WaitMsgLBunttonDownB0, "Call" ), "F", 3 ) )
myIstall := HookInstall( myConfig )
WaitUntil( Registrar, "Registrations%.Has( key )%", true )
OutputDebug( "IsDown" )

Esc::ExitApp()

;HookUn( myIstall )

