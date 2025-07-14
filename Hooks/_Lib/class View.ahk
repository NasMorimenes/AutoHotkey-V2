

class View {
	static Call( nCode, wParam, lParam ) {

		ToolTip( wParam )

		return HookCallNext( nCode, wParam, lParam )
	}
}