const UserRouter = require('express').Router()


const jwt = require('jsonwebtoken')
const validateJWT = require('../utils/validateJWT')
const UserModel = require('../models/User.model')
const multer = require('multer')
const fs = require('fs')
const storage = multer.diskStorage({
    destination: (req, res, cb) => {
        const dir = 'uploads/profileImages'
        if (fs.existsSync(dir)) {
            return cb(null, dir)
        }
        else {
            fs.mkdirSync(dir)
            return cb(null, dir)
        }
    },
    filename: (req, res, cb) => {
        const { id } = req.headers
        cb(null, `${id}.jpg`)
    }
})

const upload = multer({ storage })

UserRouter.post('/setProfileImage', upload.single('file'), (req, res) => {
    let { id } = req.headers
    res.send({ data: `http://localhost:4000/profileImages/${id}.jpg` })

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