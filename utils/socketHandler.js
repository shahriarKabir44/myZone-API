module.exports = function (socket) {
    socket.on('newPersonalMessage', data => {
        console.log(data)

    })

}