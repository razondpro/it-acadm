/* - Exercici 1
Crea una funció que retorni una Promise que invoqui la funció resolve() o reject() que rep.
 Invoca-la passant-li les dues funcions de manera que imprimeixin un missatge diferent depenent de si la Promise es resol o no. */

/**
 * Executes resolve or reject dependin on boolean param
 * @param {boolean} resOrRej 
 * @returns 
 */
 const fPromise = (resOrRej) => new Promise((resolve, reject) => {
    if(resOrRej)
        resolve(resOrRej)
    else
        reject(resOrRej)
 })

 fPromise(false)
 .then(result => console.log(`Resolved value: ${result}`))
 .catch(err => console.log(`Rejected value: ${err}`))

 /*
 - Exercici 2
 Crea una arrow function que rebi un paràmetre i una funció callback i li passi a la funció un missatge
  o un altre (que s'imprimirà per consola) en funció del paràmetre rebut.*/

  const fArrow = (param, cb) => param? cb('Aixó es true'): cb('Aixó es false')

  const cb = (param) => console.log(param)

  fArrow(true, cb )
  fArrow(false, cb)


