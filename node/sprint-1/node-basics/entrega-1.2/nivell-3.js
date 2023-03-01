// - Exercici 1
// Escriu una function creadora d'objectes que faci instàncies d'una classe abstracta. Invoca-la amb diferents definicions.




// NOTA IMPORTANTE ----NO SE PUEDE INSTANCIAR UNA CLASE ABSTRACTA ----
// JS NO TIENE IMPLEMENTACION DE CLASES ABSTRACTAS



class Person {
    constructor() {
      if (this.constructor == Person) {
        throw new Error('You can not create an instance of Abstract Class');
          
        }
      }

      sayName() {
          throw new Error('Added abstract Method has no implementation');
      }
  }

class Teacher extends Person {
    constructor (name) {
        super()
        this.name = name
    }

    sayName(){
        console.log(this.name)
    }
}

const createTeacher = (name) => new Teacher(name);

const razon = createTeacher('Razon')
const miah = createTeacher('Miah')

console.log(razon, miah)