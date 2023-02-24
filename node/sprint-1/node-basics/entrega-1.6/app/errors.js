class isNanException extends Error {
    constructor (message, code) {
        this.message = message || 'Value should be a valid number';
        this.code = code;
        this.name = "isNanException";
    }
}

class isZeroExecption extends Error {
    constructor (message, code) {
        this.message = message || 'Value can not be zero';
        this.code = code;
        this.name = "isZeroExecption";
    }
}


module.exports = {
    isNanException,
    isZeroExecption
}