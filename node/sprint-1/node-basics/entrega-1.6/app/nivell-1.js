import { isNanException, isZeroExecption } from "./errors"

/**
 * Suma dos numeros 
 * @param {number} num1 
 * @param {number} num2 
 * @returns 
 */
function sumar (num1, num2){
    if(isNaN(num1) || isNaN(num2))
        throw new isNanException('Please provide 2 numbers')

    return num1 + num2
}

/**
 * Resta dos numeros 
 * @param {number} num1 
 * @param {number} num2 
 * @returns 
 */
function restar (num1, num2){
    if(isNaN(num1) || isNaN(num2))
        throw new isNanException('Please provide 2 numbers')

    return num1 - num2
}

/**
 * Multiplica dos numeros 
 * @param {number} num1 
 * @param {number} num2 
 * @returns 
 */
function multiplicar (num1, num2){
    if(isNaN(num1) || isNaN(num2))
        throw new isNanException('Please provide 2 numbers')

    return num1 * num2
}

/**
 * Divide dos numeros 
 * @param {number} num1 
 * @param {number} num2 
 * @returns 
 */
function dividir (num1, num2){
    if(isNaN(num1) || isNaN(num2))
        throw new isNanException('Please provide 2 numbers')

    if(num1 == 0 || num2 == 0)
        throw new isZeroExecption('Please provide a valid number')

    return num1 / num2
}

module.exports = {
    sumar,
    multiplicar,
    restar,
    dividir
}