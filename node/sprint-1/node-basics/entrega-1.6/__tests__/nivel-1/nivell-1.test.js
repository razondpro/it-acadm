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

    })

    describe('Promises tests', () => {

        describe('Employees' , () => {

            it('returns employee with id 1', () => {
                return NivellU.getEmployee(1).then(data => {
                    expect(data).toEqual({id: 1, name: 'Linux Torvalds'})
                })
            })

            it('rejects when employee doesnt match', () => {
                return NivellU.getEmployee(4).catch(err => {
                    expect(err).toMatch('There is no employee with id: 4')
                })
            })
        })

        describe('Salaries' , () => {

            it('returns salary of employee with id 1', () => {
                const fakeEmployee = { id:1, name:'Linux Torvalds'}
                return NivellU.getSalary(fakeEmployee).then(data => {
                    expect(data).toBe(4000)
                })
            })

            it('rejects when employees id doesnt match', () => {
                const fakeEmployee = { id:5, name:'Linux Torvalds'}
                return NivellU.getSalary(fakeEmployee).catch(err => {
                    expect(err).toMatch(`There is no salary for employee: ${fakeEmployee}`)
                })
            })
        })

    })

    describe('Async tests', () => {

        it('executes async function properly', async () => {
            const data = await NivellU.funcioAsync()
            expect(data).toBe('Executat')
        })

        it('executes setTimeout inside function', async () => {

            jest.spyOn(global, 'setTimeout')
            const data = await NivellU.funcioAsync()
            expect(setTimeout).toHaveBeenCalledTimes(1)
            expect(setTimeout).toHaveBeenLastCalledWith(expect.any(Function), 2000)
        })

    })

})

