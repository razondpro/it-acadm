import { isNanException, isZeroExecption } from '../errors'


///////////////////////////// EXERCICI 1////////////////////////////////////
/**
 * Suma dos numeros 
 * @param {number} num1 
 * @param {number} num2 
 * @returns 
 */
function sumar (num1, num2){
    if(isNaN(num1) || isNaN(num2))
        throw new isNanException('Please provide a valid number for addition')

    return num1 + num2
}

/**
 * Resta dos numeros 
 * @param {number} num1 
 * @param {number} num2 
 * @returns 
 */
function restar (num1, num2){
    if(isNaN(num1) || isNaN(num2))
        throw new isNanException('Please provide a valid number for subtraction')

    return num1 - num2
}

/**
 * Multiplica dos numeros 
 * @param {number} num1 
 * @param {number} num2 
 * @returns 
 */
function multiplicar (num1, num2){
    if(isNaN(num1) || isNaN(num2))
        throw new isNanException('Please provide a valid number to multiply')

    return num1 * num2
}

/**
 * Divide dos numeros 
 * @param {number} num1 
 * @param {number} num2 
 * @returns 
 */
function dividir (num1, num2){
    if(isNaN(num1) || isNaN(num2))
        throw new isNanException('Please provide a valid number to divide')

    if(num1 == 0 || num2 == 0)
        throw new isZeroExecption('Cannot be divided by Zero')

    return num1 / num2
}

//////////// FI EXERCICI 1 ///////////////

///////// EXERCICI 2///////////////////
 /*Crea una arrow function que rebi un paràmetre i una funció callback i li passi a la 
 funció un missatge o un altre (que s'imprimirà per consola) en funció del paràmetre rebut.*/

  const funcioArrow = (param, cb) => param? cb('Aixó es true'): cb('Aixó es false')

  const funcioCb = (param) => console.log(param)

/////////// FI EXERCICI 2 /////////////////

/// EXERCICI 3/////////////////////////////////////////


let employees = [{
    id: 1,
    name: 'Linux Torvalds'
}, {
    id: 2,
    name: 'Bill Gates'
},{
    id: 3,
    name: 'Jeff Bezos'
}];
 
let salaries = [{
    id: 1,
    salary: 4000
}, {
    id: 2,
    salary: 1000
}, {
    id: 3,
    salary: 2000
}];

/**
 * Retorna empleat per id 
 * @param {number} id 
 * @returns 
 */
const getEmployee = (id) => new Promise((resolve, reject) => {
    const employee = employees.find((employee => employee.id == id )) 
    if(employee)
        resolve(employee)
    else
        reject(`There is no employee with id: ${id}`)
})


/**
 * Retorn el salari d'un empleat
 * @param {object} employee 
 * @returns 
 **/
const getSalary = (employee) => new Promise((resolve, reject) => {
    const e = employees.find((e => e.id == employee.id )) 
    if(!e)
        reject(`There is no salary for employee: ${employee}`)
    else {
        const salary = salaries.find((salary => salary.id == employee.id)) 
        resolve(salary.salary)
    }
        
})


/////////////////// FI EXERCICI 3 /////////////////


////////////////// EXERCICI 4 /////////////////////

function retornaPromise() {
    return new Promise( resolve => {
        setTimeout(() => resolve('Executat'),2000)
    });
}

async function executaPromise(){
    return await retornaPromise()
}


///////////////// FI EXERCICI 4 ///////////////////


export {
    sumar,
    multiplicar,
    restar,
    dividir,
    funcioArrow,
    funcioCb,
    getEmployee,
    getSalary,
    executaPromise
}