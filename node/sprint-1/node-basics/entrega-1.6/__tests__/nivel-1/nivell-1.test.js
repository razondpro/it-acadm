import * as Errors from '../../app/nivel-1/errors'
import * as MathOperations from '../../app/nivel-1/nivell-1'

describe('Level 1 tests', () => {

    describe('Calculator tests', () => {

        describe('Addition', () => {
            it('adds two numbers correctly', () => {
                expect(MathOperations.sumar(1,2)).toBe(3)
            })

            it('throws NanExpection when params are not numbers', () => {
                expect(() => MathOperations.sumar("s",20)).toThrow(Errors.isNanException)
            })

            it('expection message matches with provided message', () => {
                expect(() => MathOperations.sumar("s",20)).toThrow('Please provide a valid number for addition')
            })
        })

        describe('Subtraction', () => {
            it('Subtract of two numbers correctly', () => {
                expect(MathOperations.restar(1,2)).toBe(-1)
            })

            it('throws NanExpection when params are not numbers', () => {
                expect(() => MathOperations.restar("s",20)).toThrow(Errors.isNanException)
            })

            it('expection message matches with provided message', () => {
                expect(() => MathOperations.restar("s",20)).toThrow('Please provide a valid number for subtraction')
            })
        })

        describe('Multiply', () => {
            it('Multiplies two numbers correctly', () => {
                expect(MathOperations.multiplicar(1,2)).toBe(2)
            })

            it('throws NanExpection when params are not numbers', () => {
                expect(() => MathOperations.multiplicar("s",20)).toThrow(Errors.isNanException)
            })

            it('expection message matches with provided message', () => {
                expect(() => MathOperations.multiplicar("s",20)).toThrow('Please provide a valid number to multiply')
            })
        })

        describe('Divide', () => {
            it('Divides two numbers correctly', () => {
                expect(MathOperations.dividir(4,2)).toBe(2)
            })

            it('throws NanExpection when params are not numbers', () => {
                expect(() => MathOperations.dividir("s",20)).toThrow(Errors.isNanException)
            })

            it('expection message matches with provided message', () => {
                expect(() => MathOperations.dividir("s",20)).toThrow('Please provide a valid number to divide')
            })

            it('throws isZeroExecption when divided by zero', () => {
                expect(() => MathOperations.dividir(0,20)).toThrow(Errors.isZeroExecption)
            })

            it('throws isZeroExecption when divided by zero', () => {
                expect(() => MathOperations.dividir(0,20)).toThrow('Cannot be divided by Zero')
            })
        })


    })

})

