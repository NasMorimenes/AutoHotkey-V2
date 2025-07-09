

class Register {

    static Registration := Map()
    static Call( _ ) {

        this.Key := this.CheckKey( _ )
        if ( Type( _ ) == "String" ) {
            OutputDebug( _ )
        }
        if ( this.Key ) {
            this.Registration.Set(
               this.Key,
                _
            )

            return _.ID
        }

        return false

    }

    static CheckKey( _ ) {

        if ( !IsObject( _ ) ) {
            key  := _
        }
        else if ( IsObject( _ ) ) {
            key  := _.ID
        }
        else {
            return false
        }

       return Key
    }
 
    static Delete( _ ) {

        this.Key := this.CheckKey( _ )

        if ( this.Key ) {
            
            return this.Registration.Delete(
                this.Key
            )
        }

        return false
    }

    static Get( _ ) {

        this.Key := this.CheckKey( _ )

        if ( this.Key ) {
            
            return this.Registration.Get(
                this.Key
            )
        }

        return false
    }
}