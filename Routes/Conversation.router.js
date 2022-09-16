const ConversationRoute = require('express').Router()
const ConversationModel = require('../models/Conversation.model')
const validateJWT = require('../utils/validateJWT')

ConversationRoute.post('/createConversation', validateJWT, (req, res) => {
    ConversationModel.createConversation(req.body)
        .then((converstion) => {
            res.send({ data: converstion[0] })
        })
})
ConversationRoute.post('/getConversationMessages', validateJWT, (req, res) => {
    ConversationModel.getConversationMessages(req.body)
        .then(data => res.send({ data: data }))
})

ConversationRoute.post('/getParticipantInfo', validateJWT, (req, res) => {
    ConversationModel.getParticipantInfo(req.body).then(data => res.send({ participant: data }))
})
module.exports = ConversationRoute