const mysql = require('mysql2');
const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'Shahriar_valo_chele04',
    database: 'my_zone',
    port: 3306
})

module.exports = connection