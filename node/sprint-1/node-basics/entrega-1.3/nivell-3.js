/*
- Exercici 1

Fixa un element catch a la invocació del nivell anterior que capturi qualsevol error i el mostri per la consola.
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

/**
 * Get employee by id
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

getEmployee(5)
.then(result => console.log(result))
.catch(err => console.log(err))
