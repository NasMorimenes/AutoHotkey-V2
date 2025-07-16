/**
 * Retorna valor aninhado, navegando por propriedades, índices e métodos com argumentos.
 *
 * Caminhos válidos:
 *  - "obj.prop.sub"
 *  - "obj.array.2.valor"
 *  - "obj.GetData().Value"
 *  - "obj.FindUser('admin').Active"
 *
 * @param rootObj {Object}
 *        Objeto de partida (ex: A_GlobalNamespace ou outro).
 *
 * @param path {String}
 *        Caminho no formato `"obj.method('arg1', 2).prop"`.
 *
 * @returns {Variant}
 *          Valor resultante.
 *
 * @throws
 *          Se o caminho for inválido, método inexistente ou erro de chamada.
 */
class GetNestedValueWithMethods {

    static Call( rootObj, path ) {
        parts := StrSplit( path, "." )
        ref := rootObj

        for part in parts {
            ; ===== Método com argumentos =====
            if RegExMatch(part, "^(?<name>\w+)\((?<args>.*)\)$", &m) {
                methodName := m.name
                argsString := m.args

                if !ref.HasMethod(methodName)
                    throw Error("Método não encontrado: " methodName)

                args := ParseArguments(argsString)
                ref := ref.%methodName%(args*)
            }
            ; ===== Índice numérico =====
            else if RegExMatch(part, "^\d+$") {
                idx := Integer(part)
                if !ref.HasKey(idx)
                    throw Error("Índice " idx " não encontrado.")
                ref := ref[idx]
            }
            ; ===== Propriedade =====
            else {
                if !ref.HasOwnProp(part)
                    throw Error("Propriedade '" part "' não encontrada.")
                ref := ref[part]
            }
        }

        return ref
    }
}

class GetNestedValueWithMethodsV0 {

    static Call( rootObj, path ) {
        parts := StrSplit(path, ".")
        ref := rootObj

        for part in parts {
            ; Verifica se é chamada de método ex: "getData()"
            if RegExMatch(part, "^(\w+)\(\)$", &m) {
                methodName := m[1]
                if !ref.HasMethod(methodName)
                    throw Error("Método não encontrado: " methodName)
                ref := ref.%methodName%()
            } else if RegExMatch(part, "^\d+$") {
                ; índice numérico
                key := Integer(part)
                if !ref.HasKey(key)
                    throw Error("Índice " key " não encontrado.")
                ref := ref[key]
            } else {
                ; propriedade direta
                if !ref.HasOwnProp(part)
                    throw Error("Propriedade '" part "' não encontrada.")
                ref := ref[part]
            }
        }

        return ref
    }
}


global Dados := {
    FindUser: (user) => Map("admin", { Ativo: true })[user]
}

valor := GetNestedValueWithMethods(A_GlobalNamespace, "Dados.FindUser('admin').Ativo")
MsgBox valor  ; => true
