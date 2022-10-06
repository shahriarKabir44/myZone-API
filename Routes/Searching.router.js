const SearchingRouter = require('express').Router()
const UserModel = require('../models/User.model')
SearchingRouter.post('/users', (req, res) => {
    return UserModel.filterUsers(req.body)
        .then(users => {
            res.send({ users })
        })
})

module.exports = SearchingRouter