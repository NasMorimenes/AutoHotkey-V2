 /**
 * Espera a condição ser satisfeita com precisão e timeout opcional.
 * Suporta caminhos de propriedades aninhadas e execução assíncrona.
 *
 * @param waitCondition {Object}
 *        Objeto contendo:
 *          - PropertyPath  {String}   → Caminho da propriedade (ex: "MyObj.State.Value")
 *          - ExpectedValue {Variant}  → Valor esperado.
 *          - Callback      {Func}     → (Opcional) Função a ser executada se a condição for satisfeita.
 *          - TimeoutMs     {Integer}  → (Opcional) Tempo máximo de espera (em ms). Omissão = infinito.
 *          - Async         {Boolean}  → (Opcional) Se verdadeiro, usa SetTimer.
 * 
 * @returns {Boolean}
 *          No modo síncrono: verdadeiro se a condição for satisfeita; falso se expirar.
 *          No modo assíncrono: sempre retorna true, mas a verificação ocorre em segundo plano.
 * 
 * @throws
 *          Se o caminho de propriedade for inválido ou o objeto estiver malformado.
 * 
 * @example
 Ass := {
    PropertyPath: "x"
 }
 */
class ConditionWaiter {

    static Call( waitCondition ) {
        ; ===== Validação de entrada =====
        if (
                !waitCondition.HasOwnProp( "PropertyPath" ) or
                !waitCondition.HasOwnProp( "ExpectedValue" )
            ) {

            throw Error("Objeto de condição inválido. Campos 'PropertyPath' e 'ExpectedValue' são obrigatórios.")
        }

        path        := waitCondition.PropertyPath
        expected    := waitCondition.ExpectedValue
        callback    := waitCondition.HasOwnProp( "Callback" ) ? waitCondition.Callback : unset
        timeout     := waitCondition.HasOwnProp( "TimeoutMs" ) ? waitCondition.TimeoutMs : -1
        isAsync     := waitCondition.HasOwnProp( "Async" ) && waitCondition.Async

        if ( isAsync ) {
            this._StartAsync( path, expected, callback, timeout )
            return true
        }
        else {
            return this._StartSync( path, expected, callback, timeout )
        }
    }

    ; ========== Implementação Síncrona ==========
    static _StartSync( path, expected, callback, timeout ) {
        ; Inicializa medição de tempo
        start := A_TickCount

        ; Alta precisão com QueryPerformanceCounter
        DllCall(
            "QueryPerformanceFrequency", 
            "Int64P", &freq := 0
        )

        ticks := ( 10 * freq ) // 1000

        DllCall(
            "QueryPerformanceCounter",
            "Int64P", &last := 0
        )

        while true {
            value := this._GetValueByPath( path )
            if (value = expected) {
                if IsSet(callback) && Type(callback) == "Func"
                    callback.Call()
                return true
            }

            if (timeout >= 0 && (A_TickCount - start >= timeout))
                return false

            ; Espera precisa
            while true {
                DllCall("QueryPerformanceCounter", "Int64P", &now := 0)
                if ((now - last) >= ticks) {
                    last := now
                    break
                }
            }
        }
    }

    ; ========== Implementação Assíncrona ==========
    static _StartAsync(path, expected, callback, timeout) {
        static timerId := 0
        id := ++timerId
        start := A_TickCount

        ; Timer controlado por closure
        timerFunc := (*) => fn

        fn() {
            try {
                value := ConditionWaiter._GetValueByPath(path)
                if (value = expected) {
                    SetTimer , timerFunc, 0
                    if IsSet(callback) && Type(callback) == "Func"
                        callback.Call()
                } else if (timeout >= 0 && (A_TickCount - start >= timeout)) {
                    SetTimer , timerFunc, 0
                }
            } catch as e {
                SetTimer , timerFunc, 0
                throw e
            }
        }

        SetTimer( timerFunc, 10 )
    }

    ; ========== Acesso a propriedades aninhadas ==========
    /**
     * Retorna o valor de uma propriedade a partir de um caminho em string.
     *
     * @param path {String} Caminho no formato "Obj.Sub.Prop"
     * @returns {Variant} Valor atual da propriedade acessada.
     * @throws Se o caminho for inválido.
     */
    static _GetValueByPath(path) {
        parts := StrSplit(path, ".")
        if parts.Length = 0
            throw Error("Caminho de propriedade inválido: '" path "'.")

        ref := %parts[1]%
        if !IsSet(ref)
            throw Error("Identificador global inexistente: '" parts[1] "'.")

        Loop parts.Length - 1 {
            name := parts[A_Index + 1]
            if !ref.HasOwnProp(name)
                throw Error("Propriedade '" name "' não encontrada em: '" path "'.")
            ref := ref.%name%
        }
        return ref
    }
}
