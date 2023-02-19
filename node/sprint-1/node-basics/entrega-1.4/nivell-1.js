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
    return g
}