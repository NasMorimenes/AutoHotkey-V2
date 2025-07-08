/**
 * --
 * Cria um objeto de valor da menssagem LButtonDown
 * --
 * @example
class LButtonDown {
	static Call() {
		return {
			Value     : WM_LBUTTONDOWN,
			Type      : "MouseMensage",
            Button    : "LButton",
			ToString  : "LButton Pressionado"
		}
	}
}
 */
class LButtonDown {

	static Call() {
		return {
			Value     : WM_LBUTTONDOWN,
			Type      : "MouseMensage",
            Button    : "LButton",
			ToString  : "LButton Pressionado"
		}
	}
}


/**
 * --
 * Cria um objeto de valor da mensagem RButtonDown
 * --
 * @example
class RButtonDown {
	static Call() {
		return {
			Value     : WM_RBUTTONDOWN,
			Type      : "MouseMensage",
            Button    : "RButton",
			ToString  : "RButton Pressionado"
		}
	}
}
 */
class RButtonDown {
	static Call() {
		return {
			Value     : WM_RBUTTONDOWN,
            Opposite  : WM_RBUTTONUP,
			Type      : "MouseMensage",
            Button    : "RButton",
			ToString  : "RButton Pressionado"
		}
	}
}

/**
 * --
 * Cria um objeto de valor da mensagem MButtonDown
 * --
 * @example
class MButtonDown {
	static Call() {
		return {
			Value     : WM_MBUTTONDOWN,
			Type      : "MouseMensage",
            Button    : "MButton",
			ToString  : "MButton Pressionado"
		}
	}
}
 */
class MButtonDown {
	static Call() {
		return {
			Value     : WM_MBUTTONDOWN,
			Type      : "MouseMensage",
            Button    : "MButton",
			ToString  : "MButton Pressionado"
		}
	}
}

/**
 * --
 * Cria um objeto de valor da mensagem XButton1Down
 * --
 * @example
class XButton1Down {
	static Call() {
		return {
			Value     : WM_XBUTTONDOWN,
			Type      : "MouseMensage",
            Button    : "XButton1",
			ToString  : "XButton1 Pressionado"
		}
	}
}
 */
class XButton1Down {
	static Call() {
		return {
			;Value     : WM_XBUTTONDOWN,
			Type      : "MouseMensage",
            Button    : "XButton1",
			ToString  : "XButton1 Pressionado"
		}
	}
}

/**
 * --
 * Cria um objeto de valor da mensagem XButton2Down
 * --
 * @example
class XButton2Down {
	static Call() {
		return {
			Value     : WM_XBUTTONDOWN,
			Type      : "MouseMensage",
            Button    : "XButton2",
			ToString  : "XButton2 Pressionado"
		}
	}
}
 */
class XButton2Down {
	static Call() {
		return {
			;Value     : WM_XBUTTONDOWN,
			Type      : "MouseMensage",
            Button    : "XButton2",
			ToString  : "XButton2 Pressionado"
		}
	}
}


/**
 * --
 * Cria um objeto de valor da mensagem LButtonUp
 * --
 * @example
class LButtonUp {
	static Call() {
		return {
			Value     : WM_LBUTTONUP,
			Type      : "MouseMensage",
            Button    : "LButton",
			ToString  : "LButton Liberado"
		}
	}
}
 */
class LButtonUp {
	static Call() {
		return {
			Value     : WM_LBUTTONUP,
			Type      : "MouseMensage",
            Button    : "LButton",
			ToString  : "LButton Liberado"
		}
	}
}

/**
 * --
 * Cria um objeto de valor da mensagem RButtonUp
 * --
 * @example
class RButtonUp {
	static Call() {
		return {
			Value     : WM_RBUTTONUP,
			Type      : "MouseMensage",
            Button    : "RButton",
			ToString  : "RButton Liberado"
		}
	}
}
 */
class RButtonUp {
	static Call() {
		return {
			Value     : WM_RBUTTONUP,
			Type      : "MouseMensage",
            Button    : "RButton",
			ToString  : "RButton Liberado"
		}
	}
}

/**
 * --
 * Cria um objeto de valor da mensagem MButtonUp
 * --
 * @example
class MButtonUp {
	static Call() {
		return {
			Value     : WM_MBUTTONUP,
			Type      : "MouseMensage",
            Button    : "MButton",
			ToString  : "MButton Liberado"
		}
	}
}
 */
class MButtonUp {
	static Call() {
		return {
			Value     : WM_MBUTTONUP,
			Type      : "MouseMensage",
            Button    : "MButton",
			ToString  : "MButton Liberado"
		}
	}
}

/**
 * --
 * Cria um objeto de valor da mensagem XButton1Up
 * --
 * @example
class XButton1Up {
	static Call() {
		return {
			Value     : WM_XBUTTONUP,
			Type      : "MouseMensage",
            Button    : "XButton1",
			ToString  : "XButton1 Liberado"
		}
	}
}
 */
class XButton1Up {
	static Call() {
		return {
			;Value     : WM_XBUTTONUP,
			Type      : "MouseMensage",
            Button    : "XButton1",
			ToString  : "XButton1 Liberado"
		}
	}
}

/**
 * --
 * Cria um objeto de valor da mensagem XButton2Up
 * --
 * @example
class XButton2Up {
	static Call() {
		return {
			Value     : WM_XBUTTONUP,
			Type      : "MouseMensage",
            Button    : "XButton2",
			ToString  : "XButton2 Liberado"
		}
	}
}
 */
class XButton2Up {
	static Call() {
		return {
			Value     : WM_XBUTTONUP,
			Type      : "MouseMensage",
            Button    : "XButton2",
			ToString  : "XButton2 Liberado"
		}
	}
}