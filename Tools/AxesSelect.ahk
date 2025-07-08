#Include ..\Hooks\Lib\lib.ahk

AxesSelect( Axis ) {

    ClickButton := {
        Prop        : "WParam",
        ValueProp   : WM_LBUTTONDOWN,
        MethodCall  : "CaptureAxis",
		CaptureAxis : CaptureAxis, 
    }

	_func := UserHookCallbackTo( CaptureAxis, true )

	HookInstallFastM_LL( _func )

    CaptureAxis( wParam, lParam ) {
        if ( wParam == WM_LBUTTONDOWN ) {
            if ( Axis == "x" ) {
                x := NumGet( lParam, 0. "Int" )
                return 
            }
        }
    }

    return AxesScreen( _Value )
}


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
				ToString : Axis
			}
		}

		if ( Axis ~= "y" ) {
			yAxis := Number( StrReplace( Axis, "y", "" ) )
			if ( !this.xRange.ContainsIn( yAxis ) ) {
				throw( Error( "Fora dos Limites" ) )
			}

			return {
				Value: yAxis,
				ToString:Axis
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