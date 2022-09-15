const FriendshipRouter = require('express').Router()
const validateJWT = require('../utils/validateJWT')
const FriendShipModel = require('../models/FriendShip.model')

FriendshipRouter.get('/getFriends/:userId', validateJWT, (req, res) => {
    FriendShipModel.getFriends(req.params.userId)
        .then((friends) => {
            res.send({ data: friends })
        })
})

module.exports = FriendshipRouter
