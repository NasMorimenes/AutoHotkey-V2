

class UserHookCallbackTo {

	static Ref := 0
	static Register := Map()

	static Call( _func, Block := false ) {

		++this.Ref
		ID := this.Prototype.__Class "_" this.Ref

		this.Register[ ID ] := {
			Value    : _func,
			Block    : Block,
			Datatype : "UserHookCallbackTo"
		}

		return this.Register[ ID ]

	}
}