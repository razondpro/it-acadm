/* - Exercici 1
 Crea una matriu de deu funcions i emplena-la mitjançant un bucle de manera que cada funció compti del 0 al 9 per la consola. 
Invoca cada funció de l'array iterativament. Haurà de mostrar-se per consola el compte del 0 al 9 deu vegades. */

const matriuDeF = [];
/**
 * Funció que compte de 0 a 9 en un bucle for
 */
const fConta= () => {
    for (let i = 0; i < 10; i++) {
       console.log(`The number is ${i}`);
    }
}

for(let i = 0; i < 10; i++){
    matriuDeF.push(fConta)
}

matriuDeF.forEach(element => element());

// - Exercicis
// Crea una funció anònima autoinvocable igualada a una variable que mostri per consola el nom de l'usuari/ària a rebut com a paràmetre.

fAnonim = (nom) => console.log(nom)
fAnonim('Razon')