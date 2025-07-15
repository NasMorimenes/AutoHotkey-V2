

class MsgView extends HookProc {
	static FnCallBack( wParam, lParam ) {
		ToolTip( wParam )
		return false
	}
}