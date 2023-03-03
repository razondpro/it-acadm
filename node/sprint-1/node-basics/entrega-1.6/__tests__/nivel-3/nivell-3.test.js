import { FileReadExection } from '../../app/errors';
import * as NivellTres from '../../app/nivel-3/nivell-3'

describe('Level 3 test suites', () =>  {

    describe('Exercici-1', () => {

        it('reads json files correctly' , async () => {
            expect(async () => await NivellTres.readEmpleatFile()).not.toThrow()
        })

        /*
        it('throws error when something goes wrong reading file', async () => {

            const readFileMocked = jest.spyOn(NivellTres, 'readFile');
            readFileMocked.mockImplementation(() => { throw new Error() });

            expect(async () => await NivellTres.readEmpleatFile()).toThrow('Can not read files')

            readFileMocked.restore()
            
        })
        */

        describe('employee', () =>{

            it('finds employee with id 1',async () => {
                const data = await NivellTres.getEmployee(1)
                expect(data).toEqual({id: 1, name: 'Linux Torvalds'})
            })
    
            it('rejects when doesnt find employee',async () => {
                try{
                    await NivellTres.getEmployee(5)
                }catch(err){
                    expect(err).toMatch('There is no employee with id: 5')
                }
            })

        })


        describe('salaries', () => {

            it('returns salary of employee with id 1',async () => {
                const fakeEmployee = { id:1, name:'Linux Torvalds'}
                const data = await NivellTres.getSalary(fakeEmployee)
                expect(data).toBe(4000)


            })

            it('rejects when employees id doesnt match', async () => {
                const fakeEmployee = { id:5, name:'Linux Torvalds'}

                try{
                    await NivellTres.getSalary(fakeEmployee)
                }catch(err){
                    expect(err).toMatch(`There is no salary for employee: ${fakeEmployee}`)
                }
            })

        })


    })

    describe('Exercici 2 ', () => {

        it('throws error when empoyee id is not a number', async () => {
            try{
                await NivellTres.getEmployeeDetailsById('s')
            }catch(err){
                expect(err.message).toMatch('Please provide a valid employee id')
            }
        })

        it('throws error when param is not a number', async () => {
            try{
                await NivellTres.sumar('s',2,3)
            }catch(err){
                expect(err.message).toMatch('Provide a valid number')
            }
        })

        
        it('throws error when param is not a number', async () => {
            try{
                await NivellTres.doblaNum('s')
            }catch(err){
                expect(err).toMatch('Please provide a valid number')
            }
        })

    })

})