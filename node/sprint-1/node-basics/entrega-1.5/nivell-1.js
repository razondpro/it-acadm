/*
- Exercici 1

Crea una funció que, en executar-la, escrigui una frase en un fitxer.

*/

const fs = require('fs')
const zlib = require('zlib')

/**
 * Crea un fitxer i guarda un string en ell
 * @param {string} something string es guardará
 */
function writeSomethingToFile(something){
    // creará un fitxer en la carpeta del projecte
    fs.writeFile('text.txt',something, (err) => {
        if(err)
            console.log(err)
        else   
            console.log(`s'ha guardat`)
    })
}

writeSomethingToFile('Guardant dades al fitxer')


/*
- Exercici 2

Crea una altra funció que mostri per consola el contingut del fitxer de l'exercici anterior.
*/
/**
 * LLegeix un fitxers
 * @param {string} path 
 */
function readSomethingFromFile(path){
    fs.readFile(path, (err, data) => {
        if(err)
            console.log(err)
        else   
            console.log(`s'ha llegit: ${data}`)
    })
}


readSomethingFromFile('text.txt')

/*

- Exercici 3

Crea una funció que comprimeixi el fitxer del nivell 1.
*/


var zip = zlib.createGzip();
var read = fs.createReadStream('text.txt');
var write = fs.createWriteStream('text.txt.gz');
read.pipe(zip).pipe(write);	