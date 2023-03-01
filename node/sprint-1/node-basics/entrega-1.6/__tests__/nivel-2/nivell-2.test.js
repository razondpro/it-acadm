import * as NivellDos from '../../app/nivel-2/nivell-2'
import * as Errors from '../../app/errors'
import Persona  from '../../app/nivel-2/persona'
import Teacher from '../../app/nivel-2/abstract-persona'

jest.mock('../../app/nivel-2/Persona')


describe('Level 2 tests', () => {

    describe('Timer suite', () => {

        describe('doblaNum', () => {
            
            it('thorws NanExepction when param is not a number', () => {
                return expect(() => NivellDos.doblaNum('s')).toThrow(Errors.isNanException)
            })

            it('doubles a given number', () => {
                return NivellDos.doblaNum(2).then(data => {
                    expect(data).toBe(4)
                })
            })

        })

        describe('sumar', () => {

           /* afterEach(() => {
                jest.useRealTimers();
            });
            it('behaves expected way', async () => {
                const data = await NivellDos.sumar(1,2,3)
                expect(data).toBe(12)
            }, 6500)
        
           it('calls function doblaNum', async () => {

                jest.useFakeTimers();
                jest.spyOn(NivellDos, 'doblaNum');

                const data = await NivellDos.sumar(1,2,3)

                jest.advanceTimersByTime(6000)
                await Promise.resolve()

                await expect(NivellDos.doblaNum).toHaveBeenCalledTimes(3);
            }) 
            */
        })
    
    })


    describe('Class suites', () => {

        beforeEach(() => {
            // Clear all instances and calls to constructor and all methods:
            Persona.mockClear();
        });

        it('calls the constructor method', () => {
            const persona = new Persona('Razon')
            expect(Persona).toHaveBeenCalledTimes(1)
        })

        it('calls dirNom method', () => {
            expect(Persona).not.toHaveBeenCalled()

            const persona = new Persona('Razon')

            persona.dirNom();

            //mocked method
            const mockDirNom = Persona.mock.instances[0].dirNom

            expect(mockDirNom).toHaveBeenCalledTimes(1)
        })

    })

})