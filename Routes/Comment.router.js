const CommentRouter = require('express').Router();

const CommentModel = require('../models/Comment.model')

CommentRouter.post('/create', (req, res) => {
    CommentModel.createComment(req.body)
        .then(newComment => {
            console.log(newComment)
            res.send({ data: newComment })
        })
})

module.exports = CommentRouter
