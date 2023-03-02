import { FileReadExection } from '../../app/errors';
import * as NivellTres from '../../app/nivel-3/nivell-3'

describe('Level 3 test suites', () =>  {


    describe('Exercici-1', () => {

        it('read files correctlry' , async () => {
            const data = await NivellTres.readEmpleatFile()
            console.log(data)
        })

    })

})