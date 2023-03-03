/*
- Exercici 1

Força i captura tants errors com puguis dels nivells 1 i 2.
*/


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
 * Get employee by id
 * @param {number} id 
 * @returns 
 */
const getEmployee = (id) => new Promise((resolve, reject) => {
    if(!(typeof id === 'number')){
        reject('Please provide a valid id')
    }
    const employee = employees.find((employee => employee.id == id )) 
    if(employee)
        resolve(employee)
    else
        reject(`There is no employee with id: ${id}`)
})

/**
 * Get salary of given employee
 * @param {object} employee 
 * @returns 
 */
const getSalary = (employee) => new Promise((resolve, reject) => {
    if(!employee || !employee.id){
        reject('Provide a valid employee')
    }
    const salary = salaries.find((salary => salary.id == employee.id)) 
    if(!salary)
        reject(`There is no salary for employee: ${employee}`)
    else {
        resolve(salary.salary)
    }
        
})

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
 * 
 * @returns return promise with 2seconds
 */
function retornaPromise() {
    return new Promise( resolve => {
        setTimeout(() => resolve('Executat'),2000)
    });
}

async function executaPromise(){
    console.log(await retornaPromise())
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
 * @param {*} num1 
 * @param {*} num2 
 * @param {*} num3 
 * @returns 
 */
async function sumar(num1, num2, num3){
    if(!(typeof num1 === 'number'),
        !(typeof num2 === 'number'),
        !(typeof num3 === 'number'))
            throw new Error('Provide a valid number')

    const suma = await doblaNum(num1) +
        await doblaNum(num2)+
        await doblaNum(num3);
    return suma;    
}

// Forçant errors

getEmployee('s').catch(err => console.log(err))
getEmployee(12).catch(err => console.log(err))
getSalary({id:5, salary: 55}).catch(err => console.log(err))
getSalary({}).catch(err => console.log(err))
getEmployeeDetailsById(5).catch(err => console.log(err))
getEmployeeDetailsById("s").catch(err => console.log(err.message))
sumar("s",2,{}).catch(err => console.log(err.message))
doblaNum("s").catch(err => console.log(err))