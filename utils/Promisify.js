const connection = require('./db')

module.exports = function (sqlObject) {
    return new Promise(function (resolve, reject) {
        connection.query(sqlObject, (err, rows) => {
            if (err) reject(err)
            else resolve(rows)
        })
    })
}