const FeaturingRouter = require('express').Router();
const FeaturingModel = require('../models/Featuring.model');

FeaturingRouter.get('/getFeaturedAlbums/:createdBy', (req, res) => {
    FeaturingModel.getFeaturedAlbums(req.params.createdBy)
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
module.exports = FeaturingRouter