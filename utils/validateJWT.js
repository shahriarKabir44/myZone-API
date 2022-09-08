const jwt = require('jsonwebtoken')

module.exports = function (req, res, next) {
    var authHeader = req.headers['token']
    var token = authHeader && authHeader.split(' ')[1]
    if (!token) res.send({ data: null })
    else {
        jwt.verify(token, process.env.jwtSecret, (err, user) => {
            if (err) {
                res.send({
                    data: null
                })
            }
            else {
                req.user = user
                next()
            }
        })
    }
}