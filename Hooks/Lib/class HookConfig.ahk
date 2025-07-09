

/************************************************************************
 * ---
 * ----
 * Define o Hook( idHook ) a ser instalado e o \
 * seu Hook Procedure( lpfn )
 * ---
 * ----
 * @param _idHook {Object}
 * @param _lpfn {Object}
 * @example
class HookConfig {

    static Ref := 0

    static Call( _idHook, _lpfn, _ModuleHandle := { Value : 0 }, _DwThreadId := { Value : 0 } ) {
        
        ++this.Ref
        ID := this.Prototype.__Class "_" ID

        this.Register.Set( ID, 
            {
                IdHook      : _idHook.Value,
                Address     : _lpfn.Address,
                ID          : ID,
                HMod        : _ModuleHandle.Value,
                DwThreadId  : _DwThreadId.Value,
                Release     : Release
            }
        )

        this.Register[ ID ]

        Release( _ ) {

            if ( _lpfn.Address ) {
                _lpfn.Release()
                _.Address := _lpfn.Address
            }
        }
    }

}


;=======================================
 *
 ***********************************************************************/
class HookConfig {

    static Ref := 0

    static Call( _idHook, _lpfn, _ModuleHandle := { Value : 0 }, _DwThreadId := { Value : 0 } ) {
        
        ++this.Ref
        ID := this.Prototype.__Class "_" this.Ref

        return Register( {
                IdHook      : _idHook.Value,
                ID          : ID,
                Address     : _lpfn.Address,
                HMod        : _ModuleHandle.Value,
                DwThreadId  : _DwThreadId.Value,
                Release     : Release
            }
        )

        Release( _ ) {
            OutputDebug( "IsRelease" )
            if ( _lpfn.Address ) {                 
                ToolTip()
                _lpfn.Release()
                _.Address := _lpfn.Address
            }
        }
    }

}