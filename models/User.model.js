const jwt = require('jsonwebtoken')
const Promisify = require('../utils/Promisify')
const QueryBuilder = require('../utils/QueryBuilder')
module.exports = class User {
    static async register(userInfo) {
        let query = {
            sql: QueryBuilder.insertQuery('user', ['password', 'name', 'email']),
            values: [userInfo.password, userInfo.name, userInfo.email]
        }
        await Promisify(query)
        let newUserRow = await Promisify({
            sql: `SELECT * FROM  user where user.Id= (select max(Id) from user) ;`
        })
        return newUserRow[0]
    }

}