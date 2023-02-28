import * as Errors from '../../app/nivel-1/errors'
import * as NivellU from '../../app/nivel-1/nivell-1'

describe('Level 1 tests', () => {

    describe('Calculator tests', () => {

        describe('Addition', () => {
            it('adds two numbers correctly', () => {
                expect(NivellU.sumar(1,2)).toBe(3)
            })

            it('throws NanExpection when params are not numbers', () => {
                expect(() => NivellU.sumar("s",20)).toThrow(Errors.isNanException)
            })

            it('expection message matches with provided message', () => {
                expect(() => NivellU.sumar("s",20)).toThrow('Please provide a valid number for addition')
            })
        })

        describe('Subtraction', () => {
            it('Subtract of two numbers correctly', () => {
                expect(NivellU.restar(1,2)).toBe(-1)
            })

            it('throws NanExpection when params are not numbers', () => {
                expect(() => NivellU.restar("s",20)).toThrow(Errors.isNanException)
            })

            it('expection message matches with provided message', () => {
                expect(() => NivellU.restar("s",20)).toThrow('Please provide a valid number for subtraction')
            })
        })

        describe('Multiply', () => {
            it('Multiplies two numbers correctly', () => {
                expect(NivellU.multiplicar(1,2)).toBe(2)
            })

            it('throws NanExpection when params are not numbers', () => {
                expect(() => NivellU.multiplicar("s",20)).toThrow(Errors.isNanException)
            })

            it('expection message matches with provided message', () => {
                expect(() => NivellU.multiplicar("s",20)).toThrow('Please provide a valid number to multiply')
            })
        })

        describe('Divide', () => {
            it('Divides two numbers correctly', () => {
                expect(NivellU.dividir(4,2)).toBe(2)
            })

            it('throws NanExpection when params are not numbers', () => {
                expect(() => NivellU.dividir("s",20)).toThrow(Errors.isNanException)
            })

            it('expection message matches with provided message', () => {
                expect(() => NivellU.dividir("s",20)).toThrow('Please provide a valid number to divide')
            })

            it('throws isZeroExecption when divided by zero', () => {
                expect(() => NivellU.dividir(0,20)).toThrow(Errors.isZeroExecption)
            })

            it('throws isZeroExecption when divided by zero', () => {
                expect(() => NivellU.dividir(0,20)).toThrow('Cannot be divided by Zero')
            })
        })


    })

    describe('Callbacks tests', () => {

        
        const mockCallback = jest.fn(x => console.log(x));

        afterEach(() => {
            mockCallback.mockClear();
        });

        it('calls callback function once', () => {
            NivellU.funcioArrow(true, mockCallback)
            expect(mockCallback.mock.calls).toHaveLength(1)
        })

        it('logs -Aixó es true- when true passed as param in callback', () => {
            NivellU.funcioArrow(true, mockCallback)
            expect(mockCallback.mock.calls[0][0]).toBe('Aixó es true')
        })

        it('logs -Aixó es false- when false passed as param in callback', () => {
            NivellU.funcioArrow(false, mockCallback)
            expect(mockCallback.mock.calls[0][0]).toBe('Aixó es false')
        })

    } )

})

