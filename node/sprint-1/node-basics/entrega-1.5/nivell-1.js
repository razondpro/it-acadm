const fs = require('fs')
const zlib = require('zlib')

/*
- Exercici 1
Crea una funció que, en executar-la, escrigui una frase en un fitxer.
*/

/**
 * Crea un fitxer i guarda un string en ell
 * @param {string} something string es guardará
 * @param {string} filePath file path to save
 */
function writeSomethingToFile(something, filePath){
    // creará un fitxer en la carpeta del projecte
    return new Promise((resolve,reject) => {
        fs.writeFile(filePath, something, (err) => {
            if(err)
                reject(err)
            else   
                resolve(`File saved to ${filePath}`)
        })
    })
}


/*
- Exercici 2

Crea una altra funció que mostri per consola el contingut del fitxer de l'exercici anterior.
*/
/**
 * LLegeix un fitxers
 * @param {string} path 
 */
function readSomethingFromFile(path){

    return new Promise((resolve, reject) => {
        fs.readFile(path, (err, data) => {
            if(err)
                reject(err)
            else   
                resolve(`Reading from File ${path}: ${data}`)
        })
    })
}


/*

- Exercici 3

Crea una funció que comprimeixi el fitxer del nivell 1.
*/

function comprimeix (filePath) {
    const zip = zlib.createGzip();
    const read = fs.createReadStream(filePath);
    const write = fs.createWriteStream(`${filePath}.gz`);
    read.pipe(zip).pipe(write);	
}


const filePath = 'text.txt'
const data = 'Guardant dades al fitxer'

writeSomethingToFile(data, filePath)
.then( (val) =>{
    console.log(val)
    return readSomethingFromFile(filePath)
})
.then( (val) =>{
    console.log(val)
    comprimeix(filePath)
})
