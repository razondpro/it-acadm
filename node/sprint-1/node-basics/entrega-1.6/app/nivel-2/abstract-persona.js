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

export default class Teacher extends Person {
    constructor (name) {
        super()
        this.name = name
    }

    sayName(){
        console.log(this.name)
    }
}
