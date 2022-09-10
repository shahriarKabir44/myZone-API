const PostRouter = require('express').Router()
const multer = require('multer')
const validateJWT = require('../utils/validateJWT')
const PostModel = require('../models/Post.model')
const fs = require('fs')
const storage = multer.diskStorage({
    destination: (req, res, cb) => {
        const { postedby, postid } = req.headers
        const dir = `uploads/posts/${postedby}/${postid}`
        if (fs.existsSync(dir)) {
            return cb(null, dir)
        }
        else {
            if (!fs.existsSync('uploads/posts/')) fs.mkdirSync('uploads/posts/')
            if (!fs.existsSync(`uploads/posts/${postedby}`)) fs.mkdirSync(`uploads/posts/${postedby}`)
            if (!fs.existsSync(dir)) fs.mkdirSync(dir)

            return cb(null, dir)
        }
    },
    filename: (req, res, cb) => {
        const { postedby, postid, index } = req.headers
        req.postDir = `http://localhost:4000/posts/${postedby}/${postid}/${index}.jpg`
        cb(null, `${index}.jpg`)
    }
})

const upload = multer({ storage })

PostRouter.post('/uploadPostImage', [validateJWT, upload.single('file')], (req, res) => {

    res.send({ url: req.postDir })
})

PostRouter.post('/setPostImageURLs', validateJWT, (req, res) => {
    const { Id, attached_media } = req.body
    PostModel.setPostImage(Id, attached_media)
        .then(() => {
            res.send({ data: 'done' })
        })
})

PostRouter.post('/createPost', validateJWT, (req, res) => {
    const { postedBy, postBody } = req.body
    console.log(req.body)
    PostModel.createPost(postedBy, postBody)
        .then((newPost) => {
            res.send({ newPost: newPost[0] });
        })
})

module.exports = PostRouter