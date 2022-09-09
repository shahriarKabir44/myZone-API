const UserRouter = require('express').Router()
const upload = require('multer')()
const fs = require('fs')
const path = require('path')
const jwt = require('jsonwebtoken')
const validateJWT = require('../utils/validateJWT')
const UserModel = require('../models/User.model')

UserRouter.post('/setProfileImage', upload.array(), (req, res) => {
    let { id } = req.headers
    let dir = path.join(__dirname, '../uploads/profileImage')
    if (!fs.existsSync(dir)) fs.mkdirSync(dir)
    fs.writeFile(`${dir}/${id}.jpg`, req.body.file.replace(/^data:image\/jpeg;base64,/, "").replace(/^data:image\/jpg;base64,/, "").replace(/^data:image\/png;base64,/, "").replace(/^data:image\/webp;base64,/, ""), 'base64', (err) => {
        res.send({ data: `http://localhost:4000/profileImage/${id}.jpg` })
    })

})

UserRouter.post('/isAuthorized', validateJWT, (req, res) => {
    res.send({
        user: req.user
    })
})

UserRouter.post('/login', (req, res) => {
    let { email, password } = req.body
    UserModel.login(email, password)
        .then(userInfo => {
            if (userInfo == -1) {
                res.send({ data: -1 })
            }
            else {
                let token = jwt.sign()
                userInfo.password = ''
                res.send({ token: token, data: userInfo })
            }
        })
})

UserRouter.post('/register', (req, res) => {
    UserModel.register(req.body)
        .then(newUser => {
            let token = jwt.sign(newUser, process.env.jwtSecret)
            res.send({ Id: newUser.Id, token: token })
        })

})

UserRouter.post('/setProfileImageUrl', validateJWT, (req, res) => {
    UserModel.setProfileImage(req.body.Id, req.body.profileImage)
        .then(data => {
            let newUser = {
                ...req.user,
                profileImage: req.body.profileImage
            }
            let token = jwt.sign(newUser, process.env.jwtSecret)
            res.send({ data: 1, token: token });
        })

})
UserRouter.get('/test', (req, res) => {
    UserModel.getAll()
        .then(rows => {
            res.send({ data: rows })
        })
})

module.exports = UserRouter