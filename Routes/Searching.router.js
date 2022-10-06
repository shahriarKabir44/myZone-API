const SearchingRouter = require('express').Router()
const UserModel = require('../models/User.model')
SearchingRouter.post('/users', (req, res) => {
    UserModel.filterUsers(req.body)
        .then(users => {
            res.send({ users })
        })
})

SearchingRouter.post('/searchUsersByInterest', (req, res) => {
    UserModel.searchUsersByInterest(req.body)
        .then(users => {
            res.send({ users })
        })
})

module.exports = SearchingRouter