/////////////////////// EXERCICI 1 /////////////////////////////
 import * as Errors from '../errors'

/**
 * Dobla el numero
 * @param {number} num 
 * @returns 
*/
function doblaNum(num) {
    if(!(typeof num === 'number')){
        throw new Errors.isNanException('Provide a valid number')
    }
        
    return new Promise( resolve => {
        setTimeout(() => resolve(num*2),2000)
    });
}

/**
 * Suma tres numeross
 * @param {number} num1 
 * @param {number} num2 
 * @param {number} num3 
 * @returns 
*/
async function sumar(num1, num2, num3) {
    if(!(typeof num1 === 'number') ||
        !(typeof num2 === 'number') ||
        !(typeof num3  === 'number'))
        throw new Errors.isNanException('Provide a valid number')

    const suma = await doblaNum(num1) +
        await doblaNum(num2)+
        await doblaNum(num3);
    return suma;    
}

//////////////////// FI EXERCICI 1//////////////

export {
    sumar,
    doblaNum
} 