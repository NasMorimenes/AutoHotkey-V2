
/**
 * Valida o procedimento definido.
 * 
 * Valida e Define procedimento de gancho a ser instalado.
 * --
 * 
 * @example
#Include C:\Users\morim\Desktop\NewSigep\NewSigep\Lib..\Hooks\IDsHook\classes IDsHook.ahk
myProcedure := { Value : 55 }
myIdHook    := IdHook( myProcedure )
; */
class IdHook {

	static Ref := 0

	static ProcedureList := Map(
		"WH_CALLWNDPROC"     , WH_CALLWNDPROC,
		"WH_CALLWNDPROCRET"  , WH_CALLWNDPROCRET,
		"WH_CBT"             , WH_CBT,
		"WH_DEBUG"           , WH_DEBUG,
		"WH_FOREGROUNDIDLE"  , WH_FOREGROUNDIDLE,
		"WH_JOURNALPLAYBACK" , WH_JOURNALPLAYBACK,
		"WH_JOURNALRECORD"   , WH_JOURNALRECORD,
		"WH_KEYBOARD"        , WH_KEYBOARD,
		"WH_MOUSE"           , WH_MOUSE,
		"WH_MOUSE_LL"        , WH_MOUSE_LL,
		"WH_MSGFILTER"       , WH_MSGFILTER,
		"WH_SHELL"           , WH_SHELL,
		"WH_SYSMSGFILTER"    , WH_SYSMSGFILTER
	)
	
	static Call( _value ) {

		++this.Ref
		ID := this.Prototype.__Class "_" this.Ref

		valide := false
		for key, _class in this.ProcedureList {
			if ( _class().Value == _value.Value ) {
				valide := true
				break
			}
		}

		if ( !valide ) {
			throw( Error( "procedure indisponíveis!" ) )
		}

		return Register( {
				Value     : _value.Value,
				ID        : ID,
				DataType  : "NumericValues"
			}
		)
	}
}

/**
 * Instala um procedimento de gancho que monitora as mensagens antes que o sistema as envie para o procedimento da janela de destino. Para obter mais informações, consulte o procedimento CallWndProc hook.
 * @link https://learn.microsoft.com/pt-br/windows/win32/winmsg/callwndproc
 */
class WH_CALLWNDPROC {

	static ID   := "idHook"
	static Ref  := ""
	
	static Call() {
		return {
			Value : 4,
			Type  : "Int"
		}
	}
}

/**
 * Instala um procedimento de gancho que monitora as mensagens depois que elas são processadas pelo procedimento da janela de destino. Para obter mais informações, consulte a função de retorno de chamada HOOKPROC procedimento de gancho.
 * @link https://learn.microsoft.com/pt-br/windows/win32/api/winuser/nc-winuser-hookproc
 */
class WH_CALLWNDPROCRET {
	static ID   := "idHook"
	static Ref  := ""
	
	static Call() {
		return {
			Value: 12,
			Type: "Int"
		}
	}
}

/**
 * Instala um procedimento de gancho que recebe notificações úteis para um aplicativo CBT. Para obter mais informações, consulte o procedimento de gancho de CBTProc.
 * @link https://learn.microsoft.com/pt-br/windows/win32/winmsg/cbtproc
 */
class WH_CBT {
	static ID   := "idHook"
	static Ref  := ""
	
	static Call() {
		return {
			Value: 5,
			Type: "Int"
		}
	}
}

/**
 * Instala um procedimento de gancho útil para depurar outros procedimentos de gancho. Para obter mais informações, consulte o procedimento DebugProc hook.
 * @link https://learn.microsoft.com/pt-br/windows/win32/winmsg/debugproc
 */
class WH_DEBUG {
	static ID   := "idHook"
	static Ref  := ""
	
	static Call() {
		return {
			Value: 9,
			Type: "Int"
		}
	}
}

/**
 * Instala um procedimento de gancho que será chamado quando o thread de primeiro plano do aplicativo estiver prestes a ficar ocioso. Esse gancho é útil para executar tarefas de baixa prioridade durante o tempo ocioso. Para obter mais informações, consulte o procedimento ForegroundIdleProc hook.
 * @link https://learn.microsoft.com/pt-br/windows/win32/winmsg/foregroundidleproc
 */
class WH_FOREGROUNDIDLE {
	static ID   := "idHook"
	static Ref  := ""
	
	static Call() {
		return {
			Value: 11,
			Type: "Int"
		}
	}
}

/**
 * Instala um procedimento de gancho que monitora mensagens postadas em uma fila de mensagens. Para obter mais informações, consulte o procedimento de gancho de getMsgProc.
 */
class WH_GETMESSAGE {
	static ID   := "idHook"
	static Ref  := ""
	
	static Call() {
		return {
			Value: 3,
			Type: "Int"
		}
	}
}

/**
 * Aviso
 * As APIs do Journaling Hooks não têm suporte a partir do Windows 11 e serão removidas em uma versão futura. Por isso, é altamente recomendável chamar a API SendInput TextInput.
 * Instala um procedimento de gancho que posta mensagens gravadas anteriormente por um procedimento de gancho de WH_JOURNALRECORD. Para obter mais informações, consulte o procedimento JournalPlaybackProc hook.
 * @link https://learn.microsoft.com/pt-br/windows/win32/api/winuser/nf-winuser-sendinput
 * @link https://learn.microsoft.com/pt-br/windows/desktop/winmsg/about-hooks
 * @link https://learn.microsoft.com/pt-br/windows/win32/winmsg/journalplaybackproc
 */
class WH_JOURNALPLAYBACK {
	static ID   := "idHook"
	static Ref  := ""
	
	static Call() {
		return {
			Value: 1,
			Type: "Int"
		}
	}
}

/**
 * Aviso
 * As APIs do Journaling Hooks não têm suporte a partir do Windows 11 e serão removidas em uma versão futura. Por isso, é altamente recomendável chamar a API SendInput TextInput.
 * Instala um procedimento de gancho que registra mensagens de entrada postadas na fila de mensagens do sistema. Esse gancho é útil para gravar macros. Para obter mais informações, consulte o procedimento de gancho JournalRecordProc.
 * @link https://learn.microsoft.com/pt-br/windows/win32/api/winuser/nf-winuser-sendinput
 */
class WH_JOURNALRECORD {
	static ID   := "idHook"
	static Ref  := ""
	
	static Call() {
		return {
			Value: 0,
			Type: "Int"
		}
	}
}

/**
 * Instala um procedimento de gancho que monitora as mensagens antes que o sistema as envie para o procedimento da janela de destino. Para obter mais informações, consulte o procedimento CallWndProc hook.
 * @link https://learn.microsoft.com/pt-br/windows/win32/winmsg/keyboardproc
 */
class WH_KEYBOARD {
	static ID   := "idHook"
	static Ref  := ""
	
	static Call() {
		return {
			Value: 2,
			Type: "Int"
		}
	}
}

/**
 * Instala um procedimento de gancho que monitora eventos de entrada de teclado de baixo nível. Para obter mais informações, consulte o procedimento de gancho de LowLevelKeyboardProc.
 */
class WH_KEYBOARD_LL {
	static ID   := "idHook"
	static Ref  := ""
	
	static Call() {
		return {
			Value: 13,
			Type: "Int"
		}
	}
}

/**
 * Instala um procedimento de gancho que monitora mensagens do mouse. Para obter mais informações, consulte o procedimento de gancho MouseProc.
 */
class WH_MOUSE {
	static ID   := "idHook"
	static Ref  := ""
	
	static Call() {
		return {
			Value: 7,
			Type: "Int"
		}
	}
}

/**
 * 
 * Cria um objeto de Valor do procedimento de gancho que monitora eventos de
 * entrada de mouse de baixo nível.
 * --
 * 
 * Para obter mais informações,\
 * consulte o procedimento de gancho de lowlevelMouseProc.
 * 
 *
 * @example
 class WH_MOUSE_LL {

	static ID   := "idHook"
	static Ref  := ""

	static Call() {
		return {
			Value       : 14,
			TypeNumeric : "Int"
		}
	}
}
 */
class WH_MOUSE_LL {

	static ID   := "idHook"
	static Ref  := ""

	static Call() {
		return {
			Value       : 14,
			TypeNumeric : "Int"
		}
	}
}

/**
 * Instala um procedimento de gancho que monitora mensagens geradas como resultado de um evento de entrada em uma caixa de diálogo, caixa de mensagem, menu ou barra de rolagem. Para obter mais informações, consulte o procedimento MessageProc hook.
 * @link https://learn.microsoft.com/pt-br/windows/win32/winmsg/messageproc
 */
class WH_MSGFILTER {
	static ID   := "idHook"
	static Ref  := ""
	
	static Call() {
		return {
			Value: -1,
			Type: "Int"
		}
	}
}

/**
 * Instala um procedimento de gancho que recebe notificações úteis para aplicativos de shell. Para obter mais informações, consulte o procedimento ShellProc hook.
 * @link https://learn.microsoft.com/pt-br/windows/win32/winmsg/shellproc
 */
class WH_SHELL {
	static ID   := "idHook"
	static Ref  := ""
	
	static Call() {
		return {
			Value: 10,
			Type: "Int"
		}
	}
}

/**
 * Instala um procedimento de gancho que monitora mensagens geradas como resultado de um evento de entrada em uma caixa de diálogo, caixa de mensagem, menu ou barra de rolagem. O procedimento de gancho monitora essas mensagens para todos os aplicativos na mesma área de trabalho que o thread de chamada. Para obter mais informações, consulte o procedimento de gancho de SysMsgProc.
 */
class WH_SYSMSGFILTER {
	static ID   := "idHook"
	static Ref  := ""
	
	static Call() {
		return {
			Value: 6,
			Type: "Int"
		}
	}
}