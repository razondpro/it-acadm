import { FileReadExection } from '../errors'
const fs = require('fs');


/**
 * Find employee with id
 * @param {number} id 
 * @returns 
 */
const getEmployee =(id) => new Promise(async (resolve, reject) => {

    const data = await readEmpleatFile()
    //employees at 1st position, salaries 2nd position
    const employees = handleFile(data)[0];

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
    //employees at 1st position, salaries 2nd position
    const employees = handleFile(data)[0];
    const salaries = handleFile(data)[1];

    const e = employees.find((e => e.id == employee.id )) 

    if(!e)
        reject(`There is no salary for employee: ${employee}`)
    else {
        const salary = salaries.find((salary => salary.id == employee.id)) 
        resolve(salary.salary)
    }
        
})

/**
 * Llegeix un fitxer de manera asincrona
*/
async function readEmpleatFile(){
    let data;
    try {
        data = await fs.promises.readFile('./empleats.json')
    }
    catch(err){
        console.log(err)
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



export {
    getEmployee,
    getSalary,
    readEmpleatFile,
    handleFile
}