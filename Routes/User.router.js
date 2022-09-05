const UserRouter = require('express').Router()
const connection = require('../utils/db')
UserRouter.post('/register', (req, res) => {

})
UserRouter.get('/test', (req, res) => {
    connection.query('select * from user', (err, data) => {
        res.send(data)
    })
})

module.exports = UserRouter