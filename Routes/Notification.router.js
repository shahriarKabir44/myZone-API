const NotificationRouter = require('express').Router();

const NotificationModel = require('../models/Notification.model')

NotificationRouter.post('/create', (req, res) => {
    console.log(req.body)
    NotificationModel.create(req.body)
        .then(data => {
            res.send({ data })
        })
})


module.exports = NotificationRouter