const WebSocket = require('ws')
const socketServer = new WebSocket.Server({ port: 4030 });
const UserModel = require('../models/User.model')

socketServer.on('connection', (socket) => {

    socket.on('message', (data) => {
        let message = JSON.parse(data.toString())
        const { body } = message
        if (message.type == 'setWebSocketId') {

            const { userId } = body
            UserModel.setWebSocketId(userId, 1)
            socket.Id = userId
        }
        else if (message.type == 'personalMessage' || message.type == 'notification') {
            require('./sendWSMessage')(socketServer, message)
        }



    })
    socket.on('close', e => {
        UserModel.setWebSocketId(socket.Id, 0)
    })

})

socketServer.on('close', (e) => {
    console.log(e)
})