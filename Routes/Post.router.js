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
            fs.mkdirSync(dir)
            return cb(null, dir)
        }
    },
    filename: (req, res, cb) => {
        const { postedby, postid, index } = req.headers
        req.postDir = `posts/${postedby}/${postid}/${index}.jpg`
        cb(null, `${index}.jpg`)
    }
})

const upload = multer({ storage })

PostRouter.post('/uploadPostImage', upload.single('file'), (req, res) => {
    res.send(req.postDir)
})

PostRouter.post('/setPostImageURLs', (req, res) => {
    const { Id, attached_media } = req.body
    PostModel.setPostImage(Id, attached_media)
        .then(() => {
            res.send({ data: 'done' })
        })
})

PostRouter.post('/createPost', validateJWT, (req, res) => {
    const { postedBy, postBody } = req.body
    PostModel.createPost(postedBy, postBody)
        .then((newPost) => {
            res.send(newPost);
        })
})

module.exports = PostRouter