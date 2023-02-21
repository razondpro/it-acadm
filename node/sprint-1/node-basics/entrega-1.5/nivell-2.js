const { spawn } = require('child_process');

/*

- Exercici 1

Crea una funció que imprimeixi recursivament un missatge per la consola amb demores d'un segon.

*/


/**
 * Rep un numero enter positiu i compte fins a 0 recursivament 
 * amb interval d'un segon.
 * @param {number} num 
 */

function recursiu (num) {
    const n = num;
    if(num > 0) 
        setTimeout(() => recursiu(num -1), 1000)
    console.log(`Delayed for ${n}`)
}

recursiu(10)
/*
- Exercici 2
Crea una funció que llisti per la consola el contingut del directori d'usuari/ària de l'ordinador utilizant Node Child Processes.
    https://flaviocopes.com/how-to-spawn-child-process-node/    
    https://www.freecodecamp.org/news/node-js-child-processes-everything-you-need-to-know-e69498fe970a/
*/

/*
Es podria millorar en un futur..
const os = require("os"); // Comes with node.js
const type = os.type()
switch(type) {
    case 'Darwin':
        console.log("MacOS");
        break;
    case 'Linux': 
        console.log("Linux operating system");
        break;
    case 'Windows_NT':
        console.log("windows operating system");
        break;    
    default: 
        console.log("other operating system");
}

*/
/**
 * llista el contingut del directori de l'usuari
 * Només funcionarà a Windows
 */
function checkUserDirectory(){
    const child = spawn('dir', ['%USERPROFILE%'], {shell: true});
    child.stdout.on('data', (data) => {
      console.log(`stdout: ${data}`);
    });
      
    child.stderr.on('data', (data) => {
      console.error(`stderr: ${data}`);
    });
      
    child.on('close', (code) => {
      console.log(`child process exited with code ${code}`);
    });
}


checkUserDirectory();