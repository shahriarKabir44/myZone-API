const FriendshipRouter = require('express').Router()
const validateJWT = require('../utils/validateJWT')
const FriendShipModel = require('../models/FriendShip.model')

FriendshipRouter.get('/getFriends/:userId', validateJWT, (req, res) => {
    FriendShipModel.getFriends(req.params.userId)
        .then((friends) => {
            res.send({ data: friends })
        })
})

FriendshipRouter.post('/getFriendshipType', validateJWT, (req, res) => {
    FriendShipModel.getFriendshipType(req.body)
        .then(friendshipType => {
            res.send({ friendshipType })
        })
})
FriendshipRouter.post('/createFriendRequest', (req, res) => {
    FriendShipModel.createFriendRequest(req.body)
        .then(() => {
            res.send({ success: true })
        })
})

FriendshipRouter.post('/cancelFriendRequest', (req, res) => {
    FriendShipModel.cancelFriendRequest(req.body)
        .then(() => {
            res.send({ success: true })
        })
})

module.exports = FriendshipRouter
