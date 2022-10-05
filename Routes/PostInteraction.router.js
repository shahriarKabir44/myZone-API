const PostInteractionRouter = require('express').Router();

const PostInteraction = require('../models/PostInteraction.model')

PostInteractionRouter.post('/createComment', (req, res) => {
    PostInteraction.createComment(req.body)
        .then(newComment => {
            res.send({ data: newComment })
        })
})

PostInteractionRouter.post('/react', (req, res) => {
    PostInteraction.reactToPost(req.body)
        .then(() => res.send({ data: 1 }))
})

PostInteractionRouter.post('/hasReacted', (req, res) => {
    PostInteraction.hasReacted(req.body)
        .then(data => {
            res.send({ data: data })
        })
})

PostInteractionRouter.post('/removeReactions', (req, res) => {
    PostInteraction.removeReaction(req.body)
        .then(() => res.send({ data: 1 }))
})



module.exports = PostInteractionRouter
