

class ObjFromKeyRegistration {

	static Call( _ObjKeyRegistration ) {
		if ( _ObjKeyRegistration.DataType == "ObjKeyRegistration" ) {
			return Registrar.Registration[ _ObjKeyRegistration.ID ]
		}
	}
}