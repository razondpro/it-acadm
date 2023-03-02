class isNanException extends Error {
    constructor (message, code) {
        super(message || 'Value should be a valid number')
        this.code = code;
        this.name = "isNanException";
    }
}

class isZeroExecption extends Error {
    constructor (message, code) {
        super(message || 'Value can not be zero')
        this.code = code;
        this.name = "isZeroExecption";
    }
}

class FileReadExection extends Error {
    constructor(message, code) {
        super(message || 'Can not read file')
        this.code = code
        this.name = 'FileReadExection'
    }
}
module.exports = {
    isNanException,
    isZeroExecption,
    FileReadExection
}