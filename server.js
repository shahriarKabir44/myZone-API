const express = require('express')

const { createHandler } = require('graphql-http/lib/use/express')
const cluster = require('cluster');
const totalCPUs = require('os').cpus().length;
const validateJWT = require('./utils/validateJWT');
const { initConnection } = require('./utils/db');
const Promisify = require('./utils/Promisify');
require('dotenv').config({ path: `${__dirname}/.env.prod` })


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

    initConnection(process.env)
    app.use(express.static('uploads'))
    app.use(require('cors')())
    app.get('/', (req, res) => {
        res.send("test")
    })
    app.use(express.json())
    app.use('/user', require('./Routes/User.router'))
    app.use('/post', require('./Routes/Post.router'))
    app.use('/postInteraction', require('./Routes/PostInteraction.router'))
    app.use('/interests', validateJWT, require('./Routes/Interest.router'))
    app.use('/friendship', validateJWT, require('./Routes/Friendship.router'))
    app.use('/featuredAlbums', validateJWT, require('./Routes/Featuring.router'))
    app.use('/conversation', validateJWT, require('./Routes/Conversation.router'))
    app.use('/search', require('./Routes/Searching.router'))
    app.use('/notification', validateJWT, require('./Routes/Notification.router'))


    app.all('/graphql', createHandler({
        schema: require('./Graphql/GraphQL.Schema')
    }))

    app.get('/test', (req, res) => {
        Promisify({
            sql: `SELECT * FROM interest_names LIMIT 100`,
            values: []
        }).then(data => {
            res.send(data)
        })
    })

}

