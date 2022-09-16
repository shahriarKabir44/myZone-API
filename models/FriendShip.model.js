const Promisify = require('../utils/Promisify')
const QueryBuilder = require('../utils/QueryBuilder')

module.exports = class FriendShipModel {
    static async getFriends(userId) {
        return await Promisify({
            sql: `select name,Id,profileImage from user
            where user.Id in 
            (select friend2 from friendship where friend1=?
            and friendship_type=1); `,
            values: [userId]
        })
    }
}