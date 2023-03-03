import { FileReadExection } from '../errors'
const fs = require('fs');


/**
 * Find employee with id
 * @param {number} id 
 * @returns 
 */
const getEmployee =(id) => new Promise(async (resolve, reject) => {

    const data = await readEmpleatFile()
    const employees = handleFile(data).empleats;

    const employee = employees.find((employee => employee.id == id )) 
    if(employee)
        resolve(employee)
    else
        reject(`There is no employee with id: ${id}`)
})

/**
 * Retrieve salary of given employee
 * @param {object} employee 
 * @returns 
 */
const getSalary = async (employee) => new Promise(async (resolve, reject) => {

    const data = await readEmpleatFile()
    const employees = handleFile(data).empleats;
    const salaries = handleFile(data).salaries;

    const e = employees.find((e => e.id == employee.id )) 

    if(!e)
        reject(`There is no salary for employee: ${employee}`)
    else {
        const salary = salaries.find((salary => salary.id == employee.id)) 
        resolve(salary.salary)
    }
        
})

/**
 * Read employee file
*/
async function readEmpleatFile(){
    let data;
    try {
        data = await readFile('./app/nivel-3/empleats.json')
    }
    catch(err){
        throw new FileReadExection('Can not read files')
    }
    return data;
}

/**
 * stringyfied data to js object
 * @param {string} fileData 
 * @returns 
 */
function handleFile(fileData) {
    return JSON.parse(fileData)
}

/**
 * Reads a file
 * @param {string} path 
 * @returns 
 */
async function readFile(path){
    return await fs.promises.readFile(path)
}

/**
 * Get employee details by id
 * @param {number} employeeId 
 */
async function getEmployeeDetailsById(employeeId){

    if(!(typeof employeeId === 'number')){
        throw new Error('Please provide a valid employee id')
    }

    const employee = await getEmployee(employeeId)
    const salary = await getSalary(employee)
    console.log(`Empleat: ${employee.name}. Salari: ${salary}`)
}


/**
 * Dobla el numero
 * @param {*} num 
 * @returns 
 */
function doblaNum(num) {
    return new Promise( (resolve, reject) => {
        if(!(typeof num === 'number'))
            reject('Please provide a valid number')
        resolve(() => setTimeout(() => resolve(num*2),2000))
        
    });
}
/**
 * Suma tres numeross
 * @param {number} num1 
 * @param {number} num2 
 * @param {number} num3 
 * @returns 
 */
async function sumar(num1, num2, num3){
    if(!(typeof num1 === 'number') ||
        !(typeof num2 === 'number') ||
        !(typeof num3 === 'number'))
            throw new Error('Provide a valid number')

    const suma = await doblaNum(num1) +
        await doblaNum(num2)+
        await doblaNum(num3);
    return suma;    
}


export {
    getEmployee,
    getSalary,
    readEmpleatFile,
    handleFile,
    readFile,
    doblaNum,
    sumar,
    getEmployeeDetailsById
}