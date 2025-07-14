


class Registrar {

    static Registrations := Map()
    static Refs := Map()
    static Lists := Map()

    static Call( _ ) {

        className := _.__Class

        ; Inicialização de estruturas
        if !this.Refs.Has( className ) {
            this.Refs[ className ] := 0
		}

        if !this.Registrations.Has( className ) {
            this.Registrations[ className ] := Map()
		}

        if !this.Lists.Has( className ) {
            this.Lists[className] := ""
		}

        ; Incrementa o contador de referência
        id := className . ++this.Refs[className]
		_.ID := id

        ; Registro do objeto
        this.Registrations[className][id] := _

		;list :=
		if ( this.Lists[className] == "") {
			this.Lists[className] .= id
		}
		else {
			if ( !( this.Lists[className] ~= id ) ) {
				this.Lists[className] .= "," id
			}
		}

        return id
    }

    static Remove( _ ) {
        className := _.__Class
        if this.Registrations.Has(className)
            this.Registrations[className].Delete( _.ID )

        if this.Lists.Has(className) {
            idx := ( this.Lists[className] ~= _.ID )
            if idx
                this.Lists[className] := RegExReplace( this.Lists[className],  _.ID ",|" _.ID, "" )
        }
    }

    static GetListText( _ ) {
		list := StrSplit( this.Lists[_.__Class], "," )
		if ( list.Length ) {
			_out := ""
			for _reg in list {
				_out .= _out == "" ? _reg :"`n" _reg
			}

			return _out
		}
        return ""
    }
}



;Example Usage Registrar
ListView1( _*) {
	OutputDebug( ( _[ 1 ].ID ) )
}

Assd := Cases( ListView1 )
Id := Registrar( Assd )
OutputDebug( Id )


Registrar.Remove( Assd )
MsgBox( Assd.ID )

class Cases {

	__New( inDelete := "", beRegistered := false ) {
		this.Case := "good"
		if ( Type(inDelete) == "Func" ) {
			this.InDelete := inDelete
		}
		
	}

	__Delete() {
		try {
			if this.HasOwnProp( "InDelete" )
				this.InDelete()
		}

		;try {
		;	if this.HasOwnProp("ID")
		;		Registrar2.Remove(this, this.ID)
		;}
	}
}
