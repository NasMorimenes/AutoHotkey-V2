


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