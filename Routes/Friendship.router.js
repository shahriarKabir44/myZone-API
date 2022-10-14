const FriendshipRouter = require('express').Router()
const validateJWT = require('../utils/validateJWT')
const FriendShipModel = require('../models/FriendShip.model')

FriendshipRouter.get('/getFriends/:userId', validateJWT, (req, res) => {
    FriendShipModel.getFriends(req.params.userId)
        .then((friends) => {
            res.send({ data: friends })
        })
})

FriendshipRouter.get('/getActiveFriends/:userId', validateJWT, (req, res) => {
    FriendShipModel.getActiveFriends(req.params)
        .then((activeFriends) => {
            res.send({ activeFriends })
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

FriendshipRouter.post('/accept', (req, res) => {
    FriendShipModel.accept(req.body, req.user.Id)
        .then(() => res.send({ success: true }))
})
FriendshipRouter.post('/removeFriendshipRecord', (req, res) => {
    FriendShipModel.removeFriendshipRecord(req.body)
        .then(() => res.send({ success: true }))
})
FriendshipRouter.post('/getMutualFriends', (req, res) => {
    FriendShipModel.getMutualFriends(req.body)
        .then(mutualFriends => {
            res.send({ mutualFriends })
        })
})
FriendshipRouter.post('/countMutualFriends', (req, res) => {
    FriendShipModel.countMutualFriends(req.body)
        .then(numMutualFriends => {
            res.send({ numMutualFriends })
        })
})

FriendshipRouter.post('/findUsersWithCommonInterests', (req, res) => {
    FriendShipModel.findUsersWithCommonInterests(req.body)
        .then(usersWithCommonInterests => {
            res.send({ usersWithCommonInterests })
        })
})
module.exports = FriendshipRouter
