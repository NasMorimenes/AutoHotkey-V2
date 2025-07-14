
;myIstall := SetWindowsHook( 14, CallbackCreate( ObjBindMethod( View, "Call" ), "F", 3 ) )

;Sleep( 5000 )

;UnhookWindowsHook( myIstall )

class View {
	static Call( nCode, wParam, lParam ) {

		ToolTip( wParam )

		return HookCallNext( nCode, wParam, lParam )
	}
}

class HookCallNext {

    static Call( nCode, wParam, lParam ) {

        LRESULT :=
        DllCall(
            "CallNextHookEx",
            "Uint", 0,
            "int", nCode,
            "Uint", wParam,
            "Uint", lParam
        )

        return {
            Value: LRESULT
        }
    }
}
/*
class SetWindowsHook extends Registrar {

	static Call( idHook, lpfn ) {

		this.IdHook := idHook
		this.LpFn   := lpfn
		++this.Ref
		ID := this.Prototype.__Class "_" this.Ref

		super.Call( ID )
		this.ID := ID

		this.HandleHook :=
		DllCall(
			"SetWindowsHookExW",
			"Int", IdHook,
			"Ptr", lpfn,
			"Ptr", 0,
			"UInt", 0,
			"Ptr"
		)

		if ( this.HandleHook ) {

			this.Status := true

			this.Registration[ ID ].ID			:= this.ID
			this.Registration[ ID ].IdHook		:= this.IdHook
			this.Registration[ ID ].LpFn		:= this.LpFn
			this.Registration[ ID ].HandleHook	:= this.HandleHook
			this.Registration[ ID ].Status		:= this.Status
			this.Registration[ ID ].Release		:= this.Release
			this.Registration[ ID ].__Delete	:= this.__Delete

			return {
				ID			: ID,
				DataType 	: "ObjKeyRegistration"
			}
		}
	}

	static Release() {
		OutputDebug( "Release")
		if ( this.LpFn ) {
			CallbackFree( this.LpFn )
			this.LpFn := 0
		}
	}

	static __Delete() {
		OutputDebug( "__Delete")
		UnhookWindowsHook( this )
	}
}

class UnhookWindowsHook {

    static Call( _SetWindows ) {
		OutputDebug( "UnhookWindowsHook" )
		_SetWindowsHook := ObjFromKeyRegistration( _SetWindows )
		
        Bool :=
        DllCall(
            "UnhookWindowsHookEx",
            "Uint", _SetWindowsHook.HandleHook,
            "int"
        )

        if ( bool ) {
			_SetWindowsHook.Release()
            _SetWindowsHook.Status := false
        }
    }
}

/*
ListView( _*) {
	OutputDebug( ( _[ 1 ].ID ) )
}

Esc::ExitApp()


Ass := Cases( ListView )

;myKey := ObjKeyRegistration( Ass )
;myObj := ObjFromKeyRegistration( myKey )

;Cases.ListView()

;myObj := unset

Ass2 := Cases( ListView )

;myKey2 := ObjKeyRegistration( Ass2 )
;myObj2 := ObjFromKeyRegistration( myKey2 )

for Key, in ObjOwnProps( Ass2 ) {
	MsgBox( Key )
}


Ass2 := unset
Ass := unset

;OutputDebug Registrar.Registration.Count
;Registrar.Registration[ Ass2.ID ] := ""

;OutputDebug Registrar.Registration.Count
;Registrar.Registration.Delete( Ass2.ID )

;OutputDebug Registrar.Registration.Count
;Registrar.Registration[ Ass.ID ] := ""

;OutputDebug Registrar.Registration.Count
;Registrar.Registration.Delete( Ass.ID )
*
class Registrar  {

	static Registration := Map()

	static Call( _, OutObj ) {
		; Class data
		classEx := %_.Prototype.__Class%		
		ID := _.Prototype.__Class classEx.Ref

		if ( !this.Registration.Has( ID ) ) {
			OutObj.ID := ID
			this.Registration.Set( ID, OutObj )
			classEx.IDsList .= ( classEx.IDsList == "" ? ID : "`n" ID )
			return ID
		}
	}
}
/*
		static Registration := Map()
		static Ref := this.Ref1

		ID := this.Prototype.__Class A_Now

		if ( !this.Registration.Has( ID ) ) {
			_.ID%this.Prototype.__Class% := ID
			_.IDsList .= ( _.IDsList == "" ? ID : "`n" ID )

			this.Registration.Set( ID,
				{
					ID	: ID,
				}
			)
		}

	}

	static Registration1[ _ ] {

		get {
			static 
			return this.Registration[ _.Key ]
		}
		set {
			this.Registration[ _.Key ] := Value
		}
	}

	static __Delete() {
		this.Registration.Clear()
	}
}
*
class ObjKeyRegistration {

	static Call( _ ) {
		if ( _.HasProp( "ID" ) ) {

			return {
				ID 			: _.ID,
				DataType 	: "ObjKeyRegistration"
			}
		}
	}
}

class ObjFromKeyRegistration {

	static Call( _ObjKeyRegistration ) {
		if ( _ObjKeyRegistration.DataType == "ObjKeyRegistration" ) {
			return Registrar2.Registrations[ _ObjKeyRegistration.ID ]
		}
	}
}
/*
class Cases { ;extends Registrar {
	
	static IDsList := ""
	static Ref := 0

	static Call( inDelete := "" ) {
		++this.Ref

		;ID := super.Call()

		; Properties Class
		/*
		this.Case := "good"
		this.Registrar.Registration[ ID ].Case 	  		:= this.Case
		if ( Type( inDelete ) == "Func" ) {
			this.Registrar.Registration[ ID ].InDelete 	:= inDelete
		}
		this.Registrar.Registration[ ID ].__Delete 		:= Delete

		return {
			ID			: ID,
			DataType 	: "ObjKeyRegistration"
		}
		*
		
		; Properties OutObj
		OutObj := {}
		OutObj.Case := "good"
		if ( Type( inDelete ) == "Func" ) {
			OutObj.InDelete := inDelete
		}
		OutObj.__Delete := Delete		
		ID := Registrar( this, OutObj )

		return OutObj
		;{
		;	ID			: ID,
		;	DataType 	: "ObjKeyRegistration"
		;}

		Delete( _ ) {
			if ( _.HasOwnProp( "InDelete" ) ) {
				_.%"InDelete"%()
				return
			}
		}
	}

	static ListView() {
		ToolTip()
		SetTimer () => ToolTip( this.IDsList ), -10
		SetTimer () => ToolTip(), -5000
	}

	static __Delete() {

	}
}

/*
MsgBox("Iniciando teste. Clique OK para continuar.")

TesteSemClass()
TesteComClass()

MsgBox("Fim do script. Aguarde chamadas de __Delete(), se ocorrerem.")

ExitApp()

; --- Função com objeto sem __Class ---
TesteSemClass() {
    obj := {
        Nome: "Sem __Class",
        __Delete: (*) => MsgBox("✅ __Delete chamado para:  obj.Nome")
    }

    MsgBox("Objeto SEM __Class criado.")
    obj := unset
}

; --- Função com objeto que possui __Class ---
TesteComClass() {
    obj := {
        Nome: "Com __Class",
        __Class: "Ignorado",
        __Delete: (*) => MsgBox("❌ __Delete NÃO deveria ser chamado para: " obj.Nome)
    }

    MsgBox("Objeto COM __Class criado.")
    obj := unset
}

*

fn( Out ) {
	Key := "Obj"
	Out.Name := "ObjTest"
	Out.__Delete := Delete

	return Key

	Delete( _ ) {
		MsgBox( _.Name )
	}
}

class Register {
	static Reg := Map()

	static call( Key ) {
		if ( !this.Reg.Has( key ) ) {
			this.Reg.Set( Key, )
		}
	}

}

class ObjFromKey {
	static Call( key ) {
		return Ass[ key ]
	}
}
*/

ListView( _*) {
	OutputDebug( ( _[ 1 ].ID ) )
}

Esc::ExitApp


IdAss := Cases2( ListView )
;MsgBox( IdAss.Id )

;myKey := ObjKeyRegistration( Ass )
;myObj := ObjFromKeyRegistration( myKey )

Cases2.ListView()

;myObj := unset

Ass2 := Cases2( ListView )

Cases2.ListView()

Registrar2.Remove( Cases2, IdAss.ID )
Registrar2.Remove( Cases2, Ass2.ID )


;myKey2 := ObjKeyRegistration( Ass2 )
;myObj2 := ObjFromKeyRegistration( myKey2 )

;for Key, in ObjOwnProps( Ass2 ) {
;	MsgBox( Key )
;}


;Ass2 := unset
;Ass := unset

;OutputDebug Registrar.Registration.Count
;Registrar.Registration[ Ass2.ID ] := ""

;OutputDebug Registrar.Registration.Count
;Registrar.Registration.Delete( Ass2.ID )

;OutputDebug Registrar.Registration.Count
;Registrar.Registration[ Ass.ID ] := ""

;OutputDebug Registrar.Registration.Count
;Registrar.Registration.Delete( Ass.ID )


;Registrar2( Cases2, {} )

class Registrar2 {

    static Registrations := Map()
    static Refs := Map()
    static Lists := Map()

    static Call( callerClass, obj ) {
        className := callerClass.Prototype.__Class

        ; Inicialização de estruturas
        if !this.Refs.Has( className )
            this.Refs[ className ] := 0
        if !this.Registrations.Has( className )
            this.Registrations[ className ] := Map()
        if !this.Lists.Has( className )
            this.Lists[className] := ""

        ; Incrementa o contador de referência
        id := className . ++this.Refs[className]

        ; Registro do objeto
        obj.ID := id
        this.Registrations[className][id] := obj

        ; Lista de IDs para exibição
        ;list := this.Lists[className]
        ;if !list.Has(id)
        ;    list.Push(id)
		
		;list := 
		if ( this.Lists[className] == "") {
			this.Lists[className] .= id
		}
		else {
			if ( !( this.Lists[className] ~= id ) ) {
				this.Lists[className] .= "," ID
			}			
		}
		;if ( !this.Registration.Has( ID ) ) {
		;	_.ID%this.Prototype.__Class% := ID
		;	_.IDsList .= ( _.IDsList == "" ? ID : "`n" ID )


        return id
    }

    static Remove(callerClass, id) {
        className := callerClass.Prototype.__Class
        if this.Registrations.Has(className)
            this.Registrations[className].Delete(id)

        if this.Lists.Has(className) {
            idx := ( this.Lists[className] ~= id )
            if idx
                this.Lists[className] := RegExReplace( this.Lists[className],  id ",|" id, "" )
        }
    }

    static GetListText(callerClass) {
		list := StrSplit( this.Lists[callerClass.Prototype.__Class], "," )
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


;#Include Registrar.ahk
/*
class Cases2 {
    static Call( inDelete := "" ) {
        outObj := {}

        outObj.Case := "good"
        if IsObject(inDelete) and Type(inDelete) == "Func"
            outObj.InDelete := inDelete

        outObj.__Delete := Delete

        id := Registrar2.Call( this, outObj )
        outObj.ID := id

        return outObj

		Delete( thisObj ) {
			try {
				if thisObj.HasOwnProp("InDelete")
					thisObj.InDelete.Call()
			}

			; Remove do registro
			try {
				if thisObj.HasOwnProp("ID")
					Registrar2.Remove(this, thisObj.ID)
			}
		}
    }

    static _Delete( thisObj ) {
        try {
            if thisObj.HasOwnProp("InDelete")
                thisObj.InDelete.Call()
        }

        ; Remove do registro
        try {
            if thisObj.HasOwnProp("ID")
                Registrar2.Remove(this, thisObj.ID)
        }
    }

    static ListView() {
        ToolTip()
        SetTimer () => ToolTip( Registrar2.GetListText( Cases2 ) ), -10
        SetTimer () => ToolTip(), -5000
    }
}
*/
class Cases {
	
	__New( InDelete := "" ) {
		this.Case := "good"
		if ( Type(inDelete) == "Func" ) {
			this.InDelete := InDelete
		}

		id := Registrar2( Cases, this )
        this.ID := id.Id
	}

	__Delete() {
		try {
			if this.HasOwnProp("InDelete")
				this.InDelete.Call()
		}

		;try {
		;	if this.HasOwnProp("ID")
		;		Registrar2.Remove(this, this.ID)
		;}
	}
}
ListView1( _*) {
	OutputDebug( ( _[ 1 ].ID ) )
}
Cases( ListView1 )



class Registrar {

	static Registrations := Map()
    static Refs := Map()
    static Lists := Map()

	__New( _ ) {
		className := _.__Class
		
		; Inicialização de estruturas
        if !Registrar.Refs.Has( className )
            Registrar.Refs[ className ] := 0
        if !Registrar.Registrations.Has( className )
            Registrar.Registrations[ className ] := Map()
        if !Registrar.Lists.Has( className )
            Registrar.Lists[className] := ""

		; Incrementa o contador de referência
        id := className . ++Registrar.Refs[className]

		; Registro do objeto
        _.ID := id
        Registrar.Registrations[className][id] := _

		if ( Registrar.Lists[className] == "") {
			Registrar.Lists[className] .= id
		}
		else {
			if ( !( Registrar.Lists[className] ~= id ) ) {
				Registrar.Lists[className] .= "," ID
			}			
		}

	}
}