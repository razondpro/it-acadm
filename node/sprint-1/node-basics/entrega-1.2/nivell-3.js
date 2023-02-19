// - Exercici 1
// Escriu una function creadora d'objectes que faci instàncies d'una classe abstracta. Invoca-la amb diferents definicions.




// NOTA IMPORTANTE ----NO SE PUEDE INSTANCIAR UNA CLASE ABSTRACTA ----

class Persona {
    constructor (nom) {
        this.nom = nom
    }

    dirNom(){
        console.log(this.nom)
    }
}

const creaPersona = (nom) => new Persona(nom);

const razon = creaPersona('Razon')
const miah = creaPersona('Miah')

console.log(razon,miah)