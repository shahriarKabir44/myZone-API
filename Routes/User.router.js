const UserRouter = require('express').Router()
const connection = require('../utils/db')
const upload = require('multer')()
const fs = require('fs')
const path = require('path')
const jwt = require('jsonwebtoken')

const UserModel = require('../models/User.model')

UserRouter.post('/setProfileImage', upload.array(), (req, res) => {
    let { id } = req.headers
    let dir = path.join(__dirname, '../uploads/profileImage')
    if (!fs.existsSync(dir)) fs.mkdirSync(dir)
    fs.writeFile(`${dir}/${id}.jpg`, req.body.file.replace(/^data:image\/jpeg;base64,/, "").replace(/^data:image\/jpg;base64,/, "").replace(/^data:image\/png;base64,/, ""), 'base64', (err) => {
        res.send({ data: `${dir}/${id}.jpg` })
    })

})

UserRouter.post('/register', (req, res) => {
    UserModel.register(req.body)
        .then(newUser => {
            let token = jwt.sign(newUser, process.env.jwtSecret)
            res.send({ data: userData[0].maxId, token: token })
        })

})

UserRouter.post('/setProfileImageUrl', (req, res) => {

    connection.query(`update user set profileImage="${req.body.profileImageURL}" where Id=${req.body.Id}`, (err, data) => {
        res.send({ data: 1 })
    })
})


module.exports = UserRouter