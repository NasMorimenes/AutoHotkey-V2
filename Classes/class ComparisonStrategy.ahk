class ComparisonStrategy {

    /**
     * Cria um objeto de estratégia de comparação.
     * 
     * @param comparator {String|Func}
     *        - Um dos operadores padrão: "==", "!=", "<", ">", "<=", ">=";
     *        - Ou uma função que receba (value, expected) e retorne true/false.
     * 
     * @returns {ComparisonStrategy}
     */
    __New(comparator := "==") {
        this.comparator := comparator
    }

    /**
     * Executa a comparação entre dois valores com base no operador armazenado.
     * 
     * @param value {Variant} Valor atual.
     * @param expected {Variant} Valor esperado.
     * 
     * @returns {Boolean} Resultado da comparação.
     */
    Compare(value, expected) {
        cmp := this.comparator

        if Type(cmp) = "Func"
            return cmp.Call(value, expected)

        switch cmp {
            case "==": return value == expected
            case "!=": return value != expected
            case  "<": return value <  expected
            case  ">": return value >  expected
            case "<=": return value <= expected
            case ">=": return value >= expected
            default:
                throw Error("Operador de comparação inválido: " cmp)
        }
    }
}
