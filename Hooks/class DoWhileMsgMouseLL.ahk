#Include <lib>

class DoWhileMsgMouseLL {

    static Call( _MsgMouse ) {
        
        WaitUntil( _MsgMouse, _MsgMouse.Prop, _MsgMouse.Value, _MsgMouse.MethodCall )
    }
}

class 