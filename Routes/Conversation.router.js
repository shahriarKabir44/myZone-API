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
ConversationRoute.post('/getConversationInfo', (req, res) => {
    ConversationModel.getConversationInfo(req.body)
        .then(conversationInfo => res.send({ conversationInfo: conversationInfo[0] }))
})
ConversationRoute.post('/createMessage', (req, res) => {
    ConversationModel.createMessage(req.body)
        .then(() => {
            res.send({ data: 1 })
        })
})

ConversationRoute.get('/getNumUnreadMessages/:userId', (req, res) => {
    ConversationModel.getNumUnreadMessages(req.params.userId)
        .then(numUnreadMessages => {
            res.send({ numUnreadMessages })
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