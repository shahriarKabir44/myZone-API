const ConversationRoute = require('express').Router()
const ConversationModel = require('../models/Conversation.model')
const validateJWT = require('../utils/validateJWT')

ConversationRoute.post('/createConversation', (req, res) => {
    ConversationModel.createConversation(req.body)
        .then((conversation) => {
            res.send({ data: conversation[0] })
        })
})
ConversationRoute.post('/getConversationMessages', (req, res) => {
    ConversationModel.getConversationMessages(req.body)
        .then(data => res.send({ data: data }))
})

ConversationRoute.post('/createMessage', (req, res) => {
    ConversationModel.createMessage(req.body)
        .then(() => {
            res.send({ data: 1 })
        })
})

ConversationRoute.post('/getConversationList', (req, res) => {
    ConversationModel.getConversationList(req.body)
        .then(conversationList => {
            res.send({ conversationList: conversationList })
        })
})

ConversationRoute.post('/getParticipantInfo', (req, res) => {
    ConversationModel.getParticipantInfo(req.body).then(data => res.send({ participant: data }))
})
module.exports = ConversationRoute