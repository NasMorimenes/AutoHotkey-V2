/**
 * Converte string de argumentos em array de valores
 * Ex: "'admin', 5, true" => ["admin", 5, true]
 * 
 * @example*/
Str := "'admin', 5, true"
res := ParseArguments( Str )
OutputDebug( Res )
; */
class ParseArguments {
    static Call( str ) {
        args := []

        ; Divide por vírgula, respeitando strings com aspas simples/dobras
        pos := 1
        while pos <= StrLen( str ) {
            token := ""
            quoted := false
            quoteChar := ""

            loop {
                char := SubStr(str, pos, 1)
                ;OutputDebug( char )
                if char == "" || (!quoted && char == ",") {
                    pos += 1
                    break
                }
                token .= char
                ;OutputDebug( token )

                ; Início ou fim de string
                if (char == "'" || char == '"') {
                    if ( !quoted ) {
                        quoted := true
                        quoteChar := char
                    }
                    else if ( char == quoteChar ) {
                        quoted := false
                    }
                }

                pos += 1
            }
        

            token := Trim(token)
            ; Converte literal
            
            if RegExMatch(token, "^([`"`'])(.*)\1$", &match) {
                args.Push(match[2])
            } else if token = "true" {
                args.Push(true)
            } else if token = "false" {
                args.Push(false)
            } else if token = "null" {
                args.Push("")
            } else if RegExMatch(token, "^\d+(\.\d+)?$") {
                args.Push(token + 0)
            } else {
                throw Error("Argumento inválido ou não suportado: " token)
            }
        }

        return args
    }
}