const WebSocket = require('ws')
const socketServer = new WebSocket.Server({ port: 4030 });
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
        console.log(message);
        switch (message.type) {
            case 'setWebSocketId':
                console.log(socket.Id)
        }

    })
})

