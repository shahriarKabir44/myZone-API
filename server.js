const express = require('express')

require('dotenv').config()
const cluster = require('cluster');


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

    let app = express()
    app.use(express.json())


    app.listen(process.env.PORT || 3000)

}

