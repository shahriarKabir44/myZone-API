
const mysql = require('mysql2');
let connection = {
    connection: null
};


function initConnection(env) {
    let connectionObj = mysql.createConnection({
        host: env.dbHost,
        user: env.dbUser,
        password: env.dbPassword,
        database: env.dbName,
        port: 3306,
        ssl: JSON.parse(env.ssl)
    })
    connectionObj.connect()
    connection.connection = connectionObj
}


module.exports = { connection, initConnection }