import Person from "./abstract-persona"

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

export {
    Teacher,
    createTeacher
}
