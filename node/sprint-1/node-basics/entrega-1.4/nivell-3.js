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


const getEmployee = (id) => new Promise((resolve, reject) => {
    const employee = employees.find((employee => employee.id == id )) 
    if(employee)
        resolve(employee)
    else
        reject(`There is no employee with id: ${id}`)
})

const getSalary = (employee) => new Promise((resolve, reject) => {
    const salary = salaries.find((salary => salary.id == employee.id)) 
    if(!salary)
        reject(`There is no salary for employee: ${employee}`)
    else {
        resolve(salary.salary)
    }
        
})

async function getEmployeeDetailsById(employeeId){

    const employee = await getEmployee(employeeId)
    const salary = await getSalary(employee)
    console.log(`Empleat: ${employee.name}. Salari: ${salary}`)
}



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

// Forçant errors

getEmployee(12).catch(err => console.log(err))
getSalary({id:5, salary: 55}).catch(err => console.log(err))
getEmployeeDetailsById(5).catch(err => console.log(err))