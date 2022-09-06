const express = require('express')

const cluster = require('cluster');
const totalCPUs = require('os').cpus().length;
const connection = require('./utils/db')

connection.connect()

if (cluster.isMaster) {
    for (let i = 0; i < totalCPUs; i++) {
        cluster.fork();
    }

    cluster.on('exit', (worker, code, signal) => {
        cluster.fork();
    });

} else {
    startExpress();
}


function startExpress() {

    connection.connect()
    let app = express()
    app.use(express.static('/uploads'))
    app.use(require('cors')())
    app.use(express.json())
    app.use('/user', require('./Routes/User.router'))

    app.listen(process.env.PORT || 4000)

}

