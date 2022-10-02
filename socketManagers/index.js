const WebSocket = require('ws')
const socketServer = new WebSocket.Server({ port: 4030 });
const UserModel = require('../models/User.model')
function* socketIdGenerator() {
    let index = 0;

    while (true) {
        yield index++;
    }
}

const generator = socketIdGenerator();
socketServer.on('connection', (socket) => {
    socket.Id = generator.next().value
    socket.on('message', (data) => {
        let message = JSON.parse(data.toString())
        const { body } = message
        if (message.type == 'setWebSocketId') {

            const { userId } = body
            socket.Id = userId
        }
        else if (message.type == 'personalMessage' || message.type == 'notification') {
            require('./sendWSMessage')(socketServer, message)
        }



    })
})

