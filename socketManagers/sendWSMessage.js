const UserModel = require('../models/User.model')
module.exports = function (socketServer, message) {
    UserModel.findById(message.body.receiverId * 1)
        .then(({ websocketId }) => {
            socketServer.clients.forEach(client => {
                if (client.Id == websocketId) {

                    client.send(JSON.stringify(message))

                }
            })
        })
}   