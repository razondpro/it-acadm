/*
- Exercici 1
Crea una funció que creï dos fitxers codificats en hexadecimal i en base64 respectivament, a partir del fitxer del nivell 1.
Crea una funció que guardi els fitxers del punt anterior, ara encriptats amb l'algoritme aes-192-cbc, i esborri els fitxers inicials.
Crea una altra funció que desencripti i descodifiqui els fitxers de l'apartat anterior tornant a generar una còpia de l'inicial.
Inclou un README amb instruccions per a l'execució de cada part.
*/

const fs = require('fs')
const crypto = require('crypto')

/**
 * Crea un fitxer i guarda un string en ell
 * @param {string} something string que es guardará
 * @param {string} path nom del fitxer
 * @param {string} encoding tipus de encode
 */
function writeSomethingToFile(something, path, encoding, cb){
    // creará un fitxer en la carpeta del projecte
    fs.writeFile(path, something, encoding, cb)
}

/**
 * Llegeix un fitxer
 * @param {string} path el path del fitxer
 * @param {string} encoding tipus de encode
 * @param {Function} cb callback que s'executará despres de llegir
 */
function readSomethingFromFile(path, cb, encoding){
    fs.readFile(path, encoding, cb)
}

/**
 * Deletes a file
 * @param {string} path 
 * @param {Function} cb 
 */
function deleteFile(path, cb){
    fs.unlink(path, cb)
}
/**
 * Rep un string y l'encripta 
 * https://gist.githubusercontent.com/anned20/fcb3a97e8281b608bfcb4d046a640fe7/raw/75db3ee1159e53a08fa1709dd9e7eeef1414958f/encryption.js
 * @param {string} dataToEncrypt text a encriptar
 * @param {Object} encryptionData opcions d'encriptacio
 * @returns encrypted data
 */
function encrypt(dataToEncrypt, encryptionData) {
    // Creating Cipheriv with its parameter
    const cipher = crypto.createCipheriv(
        encryptionData.algorithm, 
        Buffer.from(encryptionData.key),
        encryptionData.iv)

    // Using concatenation
    encrypted = Buffer.concat([
        encryptionData.iv, 
        cipher.update(dataToEncrypt), 
        cipher.final()
    ])

    // Returning encrypted data
    return encrypted
}
/**
 * Rep un string y el desencripta 
 * https://gist.githubusercontent.com/anned20/fcb3a97e8281b608bfcb4d046a640fe7/raw/75db3ee1159e53a08fa1709dd9e7eeef1414958f/encryption.js
 * @param {string} dataToEncrypt text a desencriptar
 * @param {Object} encryptionData opcions d'desencriptacio
 * @param {string} encode tipus de encode del text
 * @returns decrypted data
 */
function decrypt(dataToDecrypt, encryptionData, encode){

    const iv = dataToDecrypt.slice(0, 16);
    const encryptedText = dataToDecrypt.slice(16);
    
    // Creating Decipher
    const decipher = crypto.createDecipheriv(
        encryptionData.algorithm, Buffer.from(encryptionData.key), iv);

    return Buffer.concat([decipher.update(encryptedText), decipher.final()]);
}

/**
 * Funció que executará la segona part de l'exercici
 * --Crea una funció que guardi els fitxers del punt anterior, ara encriptats
 * amb l'algoritme aes-192-cbc, i esborri els fitxers inicials.--
 * Encripta els fitxers hex y base64 creat abans y les elimina despres
 * de crear els nous fitxers encriptats
 * @param {Object} filePaths direccio de fitxer
 * @param {Object} encryptionData dades d'encriptacio
 * @param {Object} encoding tipus de encodes de fitxers
 */
function encriptaFitxers(filePaths, encryptionData, encoding){

    // llegim..creem i eliminem base64
    readSomethingFromFile(filePaths.base64,(err, data) => {
        const encryptedData = encrypt(data, encryptionData)
        writeSomethingToFile(encryptedData, filePaths.base64Encrypted, encoding.base64, (err, data) => {
            if(!err) console.log(`S'ha creat el fitxer ${filePaths.base64Encrypted}`)
            deleteFile(filePaths.base64, (err, data) => {
                if(!err) console.log(`S'ha eliminat el fitxer ${filePaths.base64}`)
            })
        })
    }, encoding.base64)

    // llegim..creem i eliminem hex
    readSomethingFromFile(filePaths.hex,(err, data) => {
        const encryptedData = encrypt(data, encryptionData)
        writeSomethingToFile(encryptedData, filePaths.hexEncrypted, encoding.hex, (err, data) => {
            if(!err) console.log(`S'ha creat el fitxer ${filePaths.hexEncrypted}`)
            deleteFile(filePaths.hex, (err, data) => {
                if(!err) console.log(`S'ha eliminat el fitxer ${filePaths.hex}`)
            })
        })
    }, encoding.hex)

}
/**
 * Desencripta fitxers 
 * Funció que executará la 3era part de l'exercici
 * Crea una altra funció que desencripti i descodifiqui els fitxers
 * de l'apartat anterior tornant a generar una còpia de l'inicial.
 * @param {Object} filePaths 
 * @param {Object} encryptionData 
 * @param {Object} encoding 
 */
function desencriptaFitxers (filePaths, encryptionData, encoding){

    //decrypt encrypted base64 file and then create a new one
    readSomethingFromFile(filePaths.base64Encrypted, (err, data) => {
        const decryptedData = decrypt(data, encryptionData, encoding.base64).toString()
        writeSomethingToFile(decryptedData, filePaths.base64, encoding.base64, (err, data) => {
            if(!err) console.log(`S'ha creat el fitxer ${filePaths.base64}`)
        })
    })
    //decrypt encrypted hex file and then create a new one
    readSomethingFromFile(filePaths.hexEncrypted, (err, data) => {
        const decryptedData = decrypt(data, encryptionData, encoding.hex).toString()
        writeSomethingToFile(decryptedData, filePaths.hex, encoding.hex, (err, data) => {
            if(!err) console.log(`S'ha creat el fitxer ${filePaths.hex}`)
        })
    })


}

/**
 * Funció que executará el primer pas de l'exercici 
 * -- Crea una funció que creï dos fitxers codificats en hexadecimal 
 * i en base64 respectivament, a partir del fitxer del nivell 1--
 * @param {Object} filePaths direccions de fitxers
 * @param {Object} encoding tipus de encodes
 */
function creaFitxersHexBase64(filePaths, encoding){
    //crea fitxer
    writeSomethingToFile('Guardant dades als fitxers', filePaths.text, encoding.utf8, (err, data) => {
        if(!err) console.log(`S'ha creat el fitxer ${filePaths.text}`)
    })

    //create file base64
    readSomethingFromFile(filePaths.text,(err, data) => {
        writeSomethingToFile(data, filePaths.base64, encoding.base64, (err, data) => {
            if(!err) console.log(`S'ha creat el fitxer ${filePaths.base64}`)
        })
    }, encoding.utf8)

    //create file hex
    readSomethingFromFile(filePaths.text,(err, data) => {
        writeSomethingToFile(data, filePaths.hex, encoding.hex, (err, data) => {
            if(!err) console.log(`S'ha creat el fitxer ${filePaths.hex}`)
        })
    }, encoding.hex)
}

/*****************EXECUCIO PROGRAMA*************************** */

const filePaths =  {
    text: 'text.txt',
    hex: 'hex.data',
    base64: 'base64.data',
    hexEncrypted: 'hex.data.enc',
    base64Encrypted: 'base64.data.enc'
}

const encoding = {
    hex: 'hex',
    base64: 'base64',
    utf8: 'utf-8'
}

const encryptionData = {
    algorithm : 'aes-256-cbc',
    key: crypto.createHash('sha256').update(String('MySuperSecretKey')).digest('base64').substring(0, 32),
    iv : crypto.randomBytes(16)
}


// - PAS 1 Creant fitxers
//creaFitxersHexBase64(filePaths, encoding);

// - PAS 2 Encriptació
//encriptaFitxers(filePaths, encryptionData, encoding)

// - PAS 3 Desencriptació
// desencriptaFitxers(filePaths, encryptionData, encoding)