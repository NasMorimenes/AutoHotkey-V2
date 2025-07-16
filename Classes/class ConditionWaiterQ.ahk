class ConditionWaiterQ {

    /**
     * Executa espera ativa com precisão baseada em QueryPerformanceCounter até a condição ser satisfeita.
     *
     * @param waitCondition {Object}
     *        Objeto contendo: PropertyName (string), ExpectedValue (any), Callback (Func, opcional).
     * 
     * @returns {Boolean}
     *          Retorna verdadeiro se a condição foi satisfeita.
     * 
     * @throws
     *          Se a propriedade for inválida ou o objeto de entrada malformado.
     */
    static Call(waitCondition) {
        ; Validação do objeto
        if !waitCondition.HasOwnProp("PropertyName") || !waitCondition.HasOwnProp("ExpectedValue")
            throw Error("Objeto de condição inválido.")

        propName := waitCondition.PropertyName
        expected := waitCondition.ExpectedValue
        callback := waitCondition.HasOwnProp("Callback") ? waitCondition.Callback : unset

        ; Frequência do contador de alta precisão
        DllCall("QueryPerformanceFrequency", "Int64P", &freq := 0)
        interval_ms := 10  ; intervalo desejado em milissegundos
        ticks := (interval_ms * freq) // 1000

        ; Marcador de tempo inicial
        DllCall("QueryPerformanceCounter", "Int64P", &lastTick := 0)

        while true {
            ; Verificar valor atual da propriedade (acesso global direto)
            if !IsSet(%propName%)
                throw Error("Propriedade não encontrada: " propName)

            current := %propName%
            if (current = expected) {
                if IsSet(callback) && Type(callback) == "Func"
                    callback.Call()
                return true
            }

            ; Espera precisa baseada em tempo decorrido
            while true {
                DllCall("QueryPerformanceCounter", "Int64P", &now := 0)
                if ((now - lastTick) >= ticks) {
                    lastTick := now
                    break
                }
            }
        }
    }
}
