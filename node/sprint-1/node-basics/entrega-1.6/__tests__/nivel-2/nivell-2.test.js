import * as NivellDos from '../../app/nivel-2/nivell-2'
import * as Errors from '../../app/errors'



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


    
})