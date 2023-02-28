/*
Donats els objectes employees i salaries, crea una arrow function getEmployee() 
que retorni una Promise efectuant la cerca en l'objecte pel seu id.
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

getEmployee(2)
.then(result => console.log(result))
.catch(err => console.log(err))

/*
- Exercici 2
Crea una altra arrow function getSalary() similar a l'anterior que rebi com a paràmetre un objecte employee i retorni el seu salari.
*/

const getSalary = (employee) => new Promise((resolve, reject) => {
    const e = employees.find((e => e.id == employee.id )) 
    if(!e)
        reject(`There is no salary for employee: ${employee}`)
    else {
        const salary = salaries.find((salary => salary.id == employee.id)) 
        resolve(salary.salary)
    }
        
})

/*
const getSalary = (employee) => {
    const salary = salaries.find((salary => salary.id == employee.id))
    return Promise.resolve(salary.salary)
}
*/

getSalary(employees[1])
.then(result => console.log(result))
.catch(err => console.log(err))

/*
- Exercici 3

Invoca la primera funció getEmployee() i després getSalary() niant l'execució de les dues promises
 de manera que es retorni per la consola el nom de l'empleat/da i el seu salari.
*/

getEmployee(2)
.then(result =>{
    console.log(`Nom: ${result.name}`)
    return getSalary(result)
})
.then(result => console.log(`Salari: ${result}`))
.catch(err => console.log(err))