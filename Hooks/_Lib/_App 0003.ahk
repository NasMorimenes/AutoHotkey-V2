#Include Lib.ahk
#Include ..\HookProcs\Lib\lib.ahk
Key :=  "wLaramMouseLL"
Method := "Registration"
myConfig := HookConfig( 14, CallbackCreate( ObjBindMethod( WaitMsgLBunttonDownB0, "Call" ), "F", 3 ) )
myIstall := HookInstall( myConfig )
WaitUntil( Registrar, "LastKeyRegistrations", "wLaramMouseLL" )
OutputDebug( "IsDown" )

Esc::ExitApp()

;HookUn( myIstall )


/*

Ass := Map(
    "Casa", "Casa10"
)
Key := "Casa"
dss := ( ObjBindMethod( Ass, "Has", Key ) )()
MsgBox( dss )