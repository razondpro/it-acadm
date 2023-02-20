/*
- Exercici 1
Crea una funció que retorni el doble del número que li passa com a paràmetre després de 2 segons.
Crea una altra funció que rebi tres números i calculi la suma dels seus dobles fent servir la funció anterior.
*/

/**
 * Dobla el numero
 * @param {*} num 
 * @returns 
 */
function doblaNum(num) {
    return new Promise( resolve => {
        setTimeout(() => resolve(num*2),2000)
    });
}
/**
 * Suma tres numeross
 * @param {*} num1 
 * @param {*} num2 
 * @param {*} num3 
 * @returns 
 */
async function sumar(num1, num2, num3){
    const suma = await doblaNum(num1) +
        await doblaNum(num2)+
        await doblaNum(num3);
    return suma;    
}

sumar(1,2,3).then(res => console.log(`La suma total es: ${res}`))

