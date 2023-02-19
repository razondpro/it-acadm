/*- Exercici 1

Crea una funció asíncrona que rebi un id d'empleat/da i imprimeixi per pantalla el nom de l'empleat/da 
i el seu salari, usant les funcions getEmployee() i getSalary() que has definit a la tasca anterior.
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
    if(!employee.id)
        reject(`There is no salary for employee: ${employee}`)
    else {
        const salary = salaries.find((salary => salary.id == employee.id)) 
        resolve(salary.salary)
    }
        
})

async function getEmployeeDetailsById(employeeId){

    const employee = await getEmployee(employeeId)
    const salary = await getSalary(employee)
    console.log(`Empleat: ${employee.name}. Salari: ${salary}`)
}

getEmployeeDetailsById(2)

/* - Exercici 2

Crea una nova funció asíncrona que cridi a una altra que retorni una Promise
 que efectuï la seva funció resolve() després de 2 segons de la seva invocació.
*/

function retornaPromise() {
    return new Promise( resolve => {
        setTimeout(() => resolve('Executat'),2000)
    });
}

async function executaPromise(){
    console.log(await retornaPromise())
}

executaPromise()