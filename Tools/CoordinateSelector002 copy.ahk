#Include ..\Hooks\_Lib\lib.ahk

class


/*
if ( Ass := CoordinateSelector( "x" ) ) {
	MsgBox( Ass.ToString )
}
else {	
	MsgBox( "TimeOff" )
}

CoordinateSelector( Axis ) {

	funcID := UserHookCallbackTo( CaptureAxis )
	Hook := HookInstallFastM_LL( funcID )
	_func := Register.Get( funcID )
	Result := WaitUntil( _func, "IsOut", true, , 10000 )
	
	if ( Result ) {
		if ( Axis == "x" ) {
			return AxesScreen( Axis _func.Out[ 1 ] )
		}
		return AxesScreen( Axis _func.Out[ 2 ] )
	}
	HookUn( _func.HookInstall )
	return false

    CaptureAxis( _, wParam, lParam ) {
		static Text := wParam
        if ( wParam == WM_LBUTTONDOWN ) {
            _.Out := [
				NumGet( lParam, 0, "Int" ),
				NumGet( lParam, 4, "Int" )
			]
			Text := "x " _.Out[ 1 ] "`ny " _.Out[ 2 ]
			_.IsOut := true
			HookUn( _.HookInstall )
        }
    }
}
*/

;mySet := CoordinateMouseSelector( RButtonDown() )
;if ( mySet.IsOut )
;	MsgBox( "x " mySet.Out[ 1 ] )
;myMsg  := RButtonDown()
;OutputDebug( myMsg.Opposite )
;_ObjKeyRegistration := HookInstallSet( 14, CallbackCreate( ObjBindMethod( CoordinateMouseSelector, "Call", myMsg ), "F", 3 ) )


;Esc::ExitApp()

class CoordinateMouseSelector extends Registrar {

	static Call( _MsgButton, nCode, wParam, lParam ) {

		ToolTip( _MsgButton.Opposite )

		return HookCallNext( nCode, wParam, lParam )
	}
}

/*
	static Ref := 0

	static Call( _MsgButton, Block := false ) {

	}
		
		_Out := {}


		this.MsgButton    := _MsgButton
		this.Block        := Block
		this.Status		  := false
		this.LpFn         := ObjBindMethod( this, "CallBack",_Out )
		this.Address      := CallbackCreate( this.LpFn, "F", 3 )
		this.IdHookID     := IdHook( WH_MOUSE_LL() )
		this.HookID       := HookInstall( this )

		
		_Out.IsOut   := false
		_Out.Block   := Block
		_Out.HookID  := this.HookID 
		_Out.End     := End

		result := WaitUntil( _Out, "IsOut", true, "End", 5000 )

		return _Out

		End( _ ) {			
			HookUn( _.HookID )
		}
	}

	static CallBack( Out, nCode, wParam, lParam ) {

		if ( nCode >= 0 and wParam == this.MsgButton.Value ) {
            Out.Out := [
				NumGet( lParam, 0, "Int" ),
				NumGet( lParam, 4, "Int" )
			]
			Out.IsOut := true
			OutputDebug( "Properties true!")
		}

		if ( Out.Block ) {
			return 1
		}

		return HookCallNext( nCode, wParam, lParam )
	}

	static Release() {
		if ( this.Address ) {     
			CallbackFree( this.Address )
			this.Address := 0
			OutputDebug( "Is Release! " this.__Class )
			return
		}
	}

	static __Delete() {
		this.Release()
	}
}

;dfg.Sat := 60
;MsgBox( dfg.ho )
;dfg.ho := 100
;MsgBox( dfg.Sat )

class dfg {

	static ho {
		get {
			return this.Sat
		}

		set {
			this.Sat := Value
		}
	}

	static Sat := 20
}

/*

	static Ref 		:= 0
	static Register := Map()
	static BaseKey 	:= "Coordinate"

	__New( Axis ) {
		
		this.IdHookID           := IdHook( WH_MOUSE_LL() )
		this.InstallHook := HookInstall( this.IdHookID, this.CallBackID )


		
	}

	HookCallbackTo() {

		return {
			Address  : CallbackCreate( ObjBindMethod( this, "DefaultCallBack" ), "F", 3 ),
			ID       : ID,
			Block    : false,
			DataType : "HookCallbackTo",
			Release  : Release
		}
	}

	CaptureCoordinate( _, wParam, lParam ) {
		static Text := wParam
		if ( wParam == WM_LBUTTONDOWN ) {
			_.Out := [
				NumGet( lParam, 0, "Int" ),
				NumGet( lParam, 4, "Int" )
			]
			Text := "x " _.Out[ 1 ] "`ny " _.Out[ 2 ]
			_.IsOut := true
			HookUn( _.HookInstall )
		}
	}

	DefaultCallBack( nCode, wParam, lParam ) {

		if ( nCode >= 0 ) {

		}

	}
}
*/
;============================================================
;============================================================
;============================================================
;============================================================
;============================================================
;============================================================
;============================================================
;============================================================


class AxesScreen {

	static xOptPARange := OptPA( 0, 1, ( A_ScreenWidth - 1 ) )
	static yOptPARange := OptPA( 0, 1, ( A_ScreenHeight - 1 ) )

	static xRange := PA( this.xOptPARange )
	static yRange := PA( this.yOptPARange )

	static Call( Axis ) {

		if ( Axis ~= "x" ) {
			xAxis := Number( StrReplace( Axis, "x", "" ) )
			if ( !this.xRange.ContainsIn( xAxis ) ) {
				throw( Error( "Fora dos Limites" ) )
			}

			return {
				Value	 : xAxis,
				ToString : xAxis Axis
			}
		}

		if ( Axis ~= "y" ) {
			yAxis := Number( StrReplace( Axis, "y", "" ) )
			if ( !this.xRange.ContainsIn( yAxis ) ) {
				throw( Error( "Fora dos Limites" ) )
			}

			return {
				Value	 : yAxis,
				ToString : yAxis Axis
			}
		}
	}

}


;============================================================
;============================================================
;============================================================
;============================================================
;============================================================
;============================================================
;============================================================
;============================================================


class OptPA {
	static Call( first, rate, limit ) {
		return {
			First  : first,
			Rate   : rate,
			Limit  : limit
		}
	}
}


;============================================================
;============================================================
;============================================================
;============================================================
;============================================================
;============================================================
;============================================================
;============================================================


/**
 *
 * @param _optPA
 * @example
class OptPA {
	static Call( first, rate, limit ) {
		return {
			First  : first,
			Rate   : rate,
			Limit  : limit
		}
	}
}
	*/
class PA {

	__New( _optPA ) {

		if ( _optPA.Rate == 0)
			throw ValueError( "Razão não pode ser zero", -1, _optPA.Rate )

		if ( !IsInteger( _optPA.First) or !IsInteger( _optPA.Rate) or !IsInteger( _optPA.Limit ))
			throw TypeError("Todos os parâmetros devem ser inteiros", -1)

		this.First := _optPA.First
		this.rate  := _optPA.Rate
		this.Limit := _optPA.Limit
	}

	; Gera a sequência PA como um array
	GerarSequencia() {

		sequencia := []
		termoAtual := this.First

		if ( this.rate > 0 ) {
			while ( termoAtual <= this.Limit ) {
				sequencia.Push( termoAtual )
				termoAtual += this.Rate
			}
		}
		else {

			while ( termoAtual >= this.Limit ) {
				sequencia.Push( termoAtual )
				termoAtual += this.Rate
			}
		}

		return sequencia
	}

	; Calcula o n-ésimo termo
	Termo( n ) {
		if ( !IsInteger(n) or n < 1 ) {
			throw ValueError( "n deve ser um inteiro positivo", -1, n )
		}

		return this.First + ( n - 1 ) * this.Rate
	}

	; Soma dos primeiros n termos
	Soma(n) {
		if (!IsInteger(n) or n < 1)
			throw ValueError("n deve ser um inteiro positivo", -1, n)

		return ( n * ( 2 * this.First + ( n - 1 ) * this.Rate ) ) // 2
	}

	; Verifica se um número pertence à PA
	ContainsIn( numero ) {
		return ContainsinPA( this, numero )
	}

	; Altera os parâmetros da PA
	Redefinir( _optPA ) {

		if ( _optPA.HasOwnProp( "First" ) ) {
			if ( !IsInteger( _optPA.First ) ) {
				throw TypeError( "Primeiro termo deve ser inteiro", -1)
			}
			this.First := _optPA.First
		}

		if ( _optPA.HasOwnProp( "Rate" ) ) {
			if ( !IsInteger( _optPA.Rate ) ) {
				throw TypeError( "Razão deve ser inteira", -1 )
			}
			if ( _optPA.Rate == 0 ) {
				throw ValueError( "Razão não pode ser zero", -1 )
			}
			this.rate := _optPA.Rate
		}

		if ( _optPA.HasOwnProp( "Limit" ) ) {
			if ( !IsInteger( _optPA.Limit ) ) {
				throw TypeError( "Limite deve ser inteiro", -1 )
			}
			this.Limit := _optPA.Limit
		}

		return this
	}
}

;============================================================
;============================================================
;============================================================
;============================================================
;============================================================
;============================================================
;============================================================
;============================================================


class ContainsinPA {

	static Call( _PA, numero ) {

		if ( !IsInteger( numero ) ) {
			return false
		}

		if ( _PA.Rate == 0 ) {
			return ( numero == _PA.First )
		}

		; Variáveis auxiliares para maior clareza
		IsMultiple := ( Mod( numero - _PA.First, _PA.Rate ) == 0 )
		IsCrescent := ( _PA.Rate > 0 )

		; Se a PA é crescente, o número deve estar entre First e Limit.
		; Se a PA é decrescente, o número deve estar entre Limit e First (pois Limit é menor).
		IsInBounds := ( (IsCrescent && numero >= _PA.First && numero <= _PA.Limit) || (!IsCrescent && numero <= _PA.First && numero >= _PA.Limit) )

		return IsMultiple && IsInBounds
	}
}