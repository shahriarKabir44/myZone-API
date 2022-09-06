const UserRouter = require('express').Router()
const connection = require('../utils/db')
const upload = require('multer')()
const fs = require('fs')
const path = require('path')
UserRouter.post('/setProfileImage', upload.array(), (req, res) => {
    let { id } = req.headers
    let dir = path.join(__dirname, '../uploads/profileImage')
    if (!fs.existsSync(dir)) fs.mkdirSync(dir)
    fs.writeFile(`${dir}/${id}.jpg`, req.body.file.replace(/^data:image\/jpeg;base64,/, "").replace(/^data:image\/jpg;base64,/, "").replace(/^data:image\/png;base64,/, ""), 'base64', (err) => {
        res.send({ data: `${dir}/${id}.jpg` })
    })

})

UserRouter.post('/register', (req, res) => {
    let { password, name, email } = req.body
    connection.query(`insert into user(password,name,email) values("${password}","${name}","${email}")`, (err, data) => {
        connection.query('select max(Id) as maxId from user', (err, userData) => {
            console.log(userData)
            res.send({ data: userData[0].maxId })
        })
    })
})

UserRouter.post('/setProfileImageUrl', (req, res) => {
    console.log(req.body)
    connection.query(`update user set profileImage="${req.body.profileImageURL}" where Id=${req.body.Id}`, (err, data) => {
        res.send({ data: 1 })
    })
})
UserRouter.get('/test', (req, res) => {
    connection.query('select * from user', (err, data) => {
        res.send(data)
    })
})

module.exports = UserRouter