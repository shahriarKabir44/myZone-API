module.exports = function (socketServer, message) {

    socketServer.clients.forEach(client => {
        if (client.Id == message.body.receiverId * 1) {

            client.send(JSON.stringify(message))

        }
    })
}   