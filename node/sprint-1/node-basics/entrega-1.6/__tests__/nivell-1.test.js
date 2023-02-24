// import * as Errors from '../app/errors'
//import * as MathOperations from '../app/nivell-1'
const { sumar } = require('../app/nivell-1');

describe('Calculator tests', () => {
    describe('Testeig sumes', () => {
        test('Suma de dos números', () => {
            sumar(1,2).toBe(3)
        })
    })
})