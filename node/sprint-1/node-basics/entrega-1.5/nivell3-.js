/*
- Exercici 1
Crea una funció que creï dos fitxers codificats en hexadecimal i en base64 respectivament, a partir del fitxer del nivell 1.
Crea una funció que guardi els fitxers del punt anterior, ara encriptats amb l'algoritme aes-192-cbc, i esborri els fitxers inicials.
Crea una altra funció que desencripti i descodifiqui els fitxers de l'apartat anterior tornant a generar una còpia de l'inicial.
Inclou un README amb instruccions per a l'execució de cada part.
*/

const fs = require('fs')

/**
 * Crea un fitxer i guarda un string en ell
 * @param {string} something string es guardará
 */
function writeSomethingToFile(something, encoding){
    // creará un fitxer en la carpeta del projecte
    fs.writeFile('text.txt',something, encoding, (err) => {
        if(err)
            console.log(err)
        else   
            console.log(`s'ha guardat`)
    })
}

/**
 * Llegeix un fitxer
 * @param {string} path 
 * @param {Function} cb 
 */
function readSomethingFromFile(path, cb){
    fs.readFile(path, (err, data) => {
        if(err)
            console.log(err)
        else   
            cb(data)
    })
}



//crea fitxer
writeSomethingToFile('Guardant dades al fitxer')

readSomethingFromFile('text.txt', (data) => {

})