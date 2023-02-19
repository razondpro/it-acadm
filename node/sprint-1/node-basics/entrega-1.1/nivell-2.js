// Exercici 1
// Mostra per consola el nom i cognoms de l'usuari/ària mitjançant template literals, guardant-los en variables i referenciant-les en la impressió del missatge.

/**
 * Funció que mostra el nom i cognoms rebut com a paràmetre
 * @param {*} nom el nom
 * @param {*} cognoms el cognom
 */
function mostraNomCognom(nom, cognoms){
    console.log(`El nom de l'usuari es ${nom} i el cognom es ${cognoms}`)
}

mostraNomCognom('Razon', 'Miah');


// Exercici 2
// Invoca una funció que retorni un valor des de dins d'una template literal.`

/**
 * Funció que suma 1 al parámetre rebut
 * @param {*} num el numero a ser sumat +1
 * @returns retorna la suma del parametre +1
 */
function mesU(num){
    return num +1
}

console.log(`2 + 1 es: ${mesU(2)}`)