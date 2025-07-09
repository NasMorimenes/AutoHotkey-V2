

class UserHookCallbackTo {

	static Ref := 0

	static Call( _func, Block := false ) {

		++this.Ref
		ID := this.Prototype.__Class "_" this.Ref

		return Register( {
				Value    : _func,
				ID		 : ID,
				Block    : Block,
				Datatype : "UserHookCallbackTo",
				Out		 : unset,
				IsOut	 : false,
				Release  : LocalRelease
			}
		)

		LocalRelease( _ ) {
			_.myInstallHook.__Delete()
		}
	}
}