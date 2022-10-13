const express = require('express')
const graphqlHTTP = require('express-graphql');
const cluster = require('cluster');
const totalCPUs = require('os').cpus().length;
const connection = require('./utils/db')
const validateJWT = require('./utils/validateJWT')
require('dotenv').config()
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


    let app = express()

    connection.connect()
    app.use(express.static('uploads'))
    app.use(require('cors')())
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
    app.use('/graphql', graphqlHTTP.graphqlHTTP(req => (
        {
            schema: require('./Graphql/GraphQL.Schema'),
            graphiql: true
        }
    )));
    app.listen(process.env.PORT || 4000)

}

