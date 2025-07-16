; ========== Acesso a propriedades aninhadas ==========
/**
 * Retorna o valor de uma propriedade a partir de um caminho em string.
 *
 * @param path {String} Caminho no formato "Obj.Sub.Prop"
 * @returns {Variant} Valor atual da propriedade acessada.
 * @throws Se o caminho for inválido.
 * 
 * @example
myArray := [ 10, 20 ]
path := "myArray.Length"
MsgBox( GetValueByPath( path ) )
; */
class GetValueByPath {

	static Call( path ) {
		parts := StrSplit( path, "." )
		if ( parts.Length == 0 ) {
			throw Error("Caminho de propriedade inválido: '" path "'." )
		}

		ref := %parts[1]%
		OutputDebug( ( ref[ 2 ]) )
		if ( !IsSet( ref ) ) {
			throw Error("Identificador global inexistente: '" parts[1] "'.")
		}

		Loop ( parts.Length - 1 ) {
			name := parts[ A_Index + 1 ]

			if ( !ref.HasProp( name ) ) {
				throw Error("Propriedade '" name "' não encontrada em: '" path "'.")
			}
			ref := ref.%name%
		}

		return ref
	}
}