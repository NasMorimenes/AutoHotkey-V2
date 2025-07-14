/*
	Ass := Cases()

	myKey := ObjKeyRegistration( Ass )

	myObj := ObjFromKeyRegistration( myKey )

	MsgBox( myObj.Case )
*/


class Registrar  {

	static Registration := Map()
	static Ref := 0

	static Call() {
		Out := {}
		Out.Ref := this.Ref
		Out.ID := this.Prototype.__Class "_" this.Ref

		if ( !this.Registration.Has( Out.ID ) ) {
			this.Registration.Set(
				Out.ID,
				Out
			)
		}

	}
}