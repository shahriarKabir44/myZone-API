const InterestModel = require('../models/Interests.model')
const InterestRouter = require('express').Router()

InterestRouter.get('/getInterestList/:userId', function (req, res) {
    InterestModel.getUserInterests(req.params.userId)
        .then((interests) => {
            res.send({ interests: interests });
        })
})
InterestRouter.get('/getOtherInterests/:userId', function (req, res) {
    InterestModel.getOtherInterests(req.params.userId)
        .then(otherInterests => {
            res.send(otherInterests);
        })
})
InterestRouter.post('/addInterest', (req, res) => {
    InterestModel.addInterest(req.body)
        .then((result) => {
            res.send({ data: 1 });
        })
})
InterestRouter.post('/removeInterest', (req, res) => {
    InterestModel.removeInterest(req.body)
        .then(() => {
            res.send({ data: 1 });
        });
});
InterestRouter.post('/createInterest', (req, res) => {
    InterestModel.createInterest(req.body)
        .then((interest) => {
            res.send({ data: 1 });

        });
})

InterestRouter.post('/getCommonInterest', (req, res) => {
    InterestModel.getCommonInterest(req.body)
        .then((commonInterests) => {
            res.send({ commonInterests })
        })
})
module.exports = InterestRouter