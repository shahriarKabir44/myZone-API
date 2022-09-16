const ConversationRoute = require('express').Router()
const ConversationModel = require('../models/Conversation.model')
const validateJWT = require('../utils/validateJWT')

ConversationRoute.post('/createConversation', validateJWT, (req, res) => {
    ConversationModel.createConversation(req.body)
        .then((converstion) => {
            res.send({ data: converstion[0] })
        })
})

module.exports = ConversationRoute