#Include class ParseArguments.ahk

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
 * 
 * @example*/
#Include class ParseArguments.ahk

A_GlobalNamespace := {
    FindUser: ( _, user ) => Map("10", { Ativo: true })[user]
}

valor := GetNestedValueWithMethods(A_GlobalNamespace, "FindUser('10').Ativo")
MsgBox valor  ; => true
; */
class GetNestedValueWithMethods {

    static Call( rootObj, path ) {
        parts := StrSplit( path, "." )
        for key in parts {
            MsgBox( key )
        }
        ref := rootObj

        for part in parts {
            ; ===== Método com argumentos =====
            if RegExMatch( part, "^(?<methodName>\w+)\((?<args>.*)\)$", &m ) {
                methodName := m.methodName
                argsString := m.args

                if ( !ref.HasMethod(methodName) ) {
                    throw Error("Método não encontrado: " methodName)
                }

                args := ParseArguments(argsString)
                ref := ref.%methodName%(args*)
            }
            ; ===== Índice numérico =====
            else if RegExMatch( part, "^\d+$" ) {
                idx := Integer( part )

                if !ref.HasKey( idx )
                    throw Error("Índice " idx " não encontrado.")
                ref := ref[ idx ]
            }
            ; ===== Propriedade =====
            else {
                MsgBox( part )
                if ( !ref.HasOwnProp( part ) ) {
                    throw Error( "Propriedade '" part "' não encontrada." )
                }
                ref := ref[ part ]
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


/*
class GetNestedValue {
    ; Permite buscar um valor aninhado em um objeto (Map, Array, ou objeto personalizado),
    ; incluindo chamadas de método com e sem argumentos.
    ;
    ; Parâmetros:
    ;   rootObj: O objeto inicial para começar a busca.
    ;   path: Uma string que descreve o caminho para o valor desejado,
    ;         usando notação de ponto (ex: "user.address.street", "data[0].getName()").
    ;         Suporta:
    ;           - Propriedades diretas (ex: "propriedade")
    ;           - Índices numéricos (ex: "0", "1") para Arrays.
    ;           - Chamadas de método (ex: "getName()", "calculate(10, 20)").
    ;
    ; Retorna: O valor encontrado no caminho especificado.
    ; Lança: Um objeto Error se o caminho for inválido ou uma parte não for encontrada.
    static Call(rootObj, path) {
        ; Remove espaços em branco extras ao redor dos pontos para limpeza
        cleanPath := RegExReplace(path, "\s*\.\s*", ".")
        parts := StrSplit(cleanPath, ".")
        ref := rootObj

        for index, part in parts {
            if (ref == unset) { ; Verifica se ref se tornou 'unset' em uma iteração anterior
                throw Error("Caminho inválido: Parte anterior retornou 'unset' ou não existe no caminho: '" cleanPath "'")
            }

            ; 1. Verifica se é uma chamada de método com ou sem argumentos: methodName(arg1, arg2, ...)
            ; O padrão foi aprimorado para capturar o nome do método e os argumentos.
            ; ^(?<methodName>\w+)\((?<args>.*)\)$
            if RegExMatch(part, "^(?<methodName>\w+)\((?<args>.*)\)$", &m) {
                methodName := m.methodName
                argsString := m.args
                args := [] ; Inicializa um array para armazenar os argumentos

                ; Se houver argumentos, tenta parseá-los.
                ; Isso é uma simplificação. Um parser de argumentos robusto seria mais complexo.
                ; Aqui, assumimos que os argumentos são separados por vírgulas e podem ser
                ; strings (entre aspas duplas) ou números/booleanos/null.
                if (argsString != "") {
                    ; Simples parser de argumentos: separa por vírgula e tenta avaliar
                    ; NOTA: Para um parser robusto que lide com strings com vírgulas internas,
                    ; ou objetos aninhados como argumentos, seria necessário um parser JSON ou similar.
                    ; Esta versão é mais básica.
                    For argPart in StrSplit(argsString, ",") {
                        trimmedArg := Trim(argPart)
                        if (trimmedArg = "true") {
                            args.Push(true)
                        } else if (trimmedArg = "false") {
                            args.Push(false)
                        } else if (trimmedArg = "null") {
                            args.Push(unset) ; AHK v2 usa 'unset' para null/nil
                        } else if (trimmedArg ~= "^-?\d+(\.\d+)?$") { ; Verifica se é um número (inteiro ou float)
                            args.Push(Number(trimmedArg))
                        } else if (trimmedArg ~= "^""(.*)""$") { ; Verifica se é uma string entre aspas duplas
                            ; Remove as aspas duplas
                            args.Push(SubStr(trimmedArg, 2, StrLen(trimmedArg) - 2))
                        } else {
                            ; Se não for um dos tipos acima, assume que é uma variável ou literal não string/numero/booleano
                            ; Para maior segurança, pode-se lançar um erro ou tratar como string literal.
                            ; Aqui, vamos apenas adicionar como string.
                            args.Push(trimmedArg)
                        }
                    }
                }

                if !ref.HasMethod(methodName) {
                    throw Error("Método não encontrado: '" methodName "' na parte '" part "' do caminho: '" cleanPath "'")
                }
                
                ; Chama o método dinamicamente, passando os argumentos se existirem
                ref := ref.%methodName%(args*) ; Usa o operador splat (*) para expandir o array de argumentos

            }
            ; 2. Verifica se é um índice numérico (para Arrays ou Maps com chaves numéricas)
            else if RegExMatch(part, "^\d+$") {
                key := Integer(part)
                if !ref.HasKey(key) {
                    throw Error("Índice numérico " key " não encontrado na parte '" part "' do caminho: '" cleanPath "'")
                }
                ref := ref[key]
            }
            ; 3. Se não for método nem índice numérico, trata como propriedade direta (string key para Maps/Objects)
            else {
                if !ref.HasOwnProp(part) && !ref.HasMethod(part) && !ref.HasKey(part) { ; Verifica também se não é uma chave de mapa
                    throw Error("Propriedade ou chave '" part "' não encontrada na parte '" part "' do caminho: '" cleanPath "'")
                }
                ref := ref[part]
            }
        }
        return ref
    }
}