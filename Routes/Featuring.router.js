const FeaturingRouter = require('express').Router();
const FeaturingModel = require('../models/Featuring.model');

FeaturingRouter.post('/getFeaturedAlbums', (req, res) => {
    FeaturingModel.getFeaturedAlbums(req.body)
        .then(featuredAlbums => {
            res.send({ featuredAlbums })
        })

})
FeaturingRouter.post('/createFeaturedAlbum', (req, res) => {
    FeaturingModel.createFeaturedAlbum(req.body)
        .then(featuredAlbum => {
            res.send({ featuredAlbum })
        })
})
FeaturingRouter.post('/addPhotoToFeaturedAlbum', (req, res) => {
    FeaturingModel.addPhotoToFeaturedAlbum(req.body)
        .then(data => {
            res.send({ data: 1 })
        })
})
module.exports = FeaturingRouter