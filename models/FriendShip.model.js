const Promisify = require('../utils/Promisify')
const QueryBuilder = require('../utils/QueryBuilder')

module.exports = class FriendShipModel {
    static async getFriends(userId) {
        return await Promisify({
            sql: `select name,Id,profileImage from user
            where user.Id in 
            (select friend2 from friendship where friend1=?
            and friendship_type=1); `,
            values: [userId * 1]
        })
    }
    static async cancelFriendRequest({ userId, friendId }) {
        return Promise.all([
            Promisify({
                sql: `delete from friendship where (friend1=? and friend2=?) 
                    or (friend1=? and friend2=?);`,
                values: [userId * 1, friendId * 1, friendId * 1, userId * 1]
            })
        ])
    }
    static async getActiveFriends(userId) {
        return await Promisify({
            sql: `select name,Id,profileImage from user
            where user.Id in 
            (select friend2 from friendship where friend1=?
            and friendship_type=1) user.websocketid=1 ; `,
            values: [userId * 1]
        })
    }
    static async getFriendshipType({ userId, friendId }) {
        let status = await Promisify({
            sql: `select friendship_type from friendship
            where friend1=? and friend2=?;`,
            values: [userId * 1, friendId * 1]
        })
        if (status.length > 0) return status[0].friendship_type
        else return 0
    }
    static async createFriendRequest({ userId, friendId }) {
        const now = (new Date()) * 1
        return await Promise.all([
            Promisify({
                sql: `insert into friendship(friend1,friend2,friendship_type,initiation_time)
                    values (?,?,?,?)`,
                values: [userId * 1, friendId * 1, 2, now]
            }),
            Promisify({
                sql: `insert into friendship(friend1,friend2,friendship_type,initiation_time)
                    values (?,?,?,?)`,
                values: [friendId * 1, userId * 1, 3, now]
            })
        ])
    }
    static async removeFriendshipRecord({ friend1, friend2 }) {
        return await Promise.all([
            Promisify({
                sql: `delete from friendship where 
                    (friend1=? and friend2=?) 
                    or (friend1=? and friend2=?);`,
                values: [friend1 * 1, friend2 * 1, friend2 * 1, friend1 * 1]
            })
        ])
    }
    static async accept({ friend1, friend2 }) {
        return Promisify({
            sql: `update friendship set friendship_type=1 
                   (friend1=? and friend2=?) 
                    or (friend1=? and friend2=?);`,
            values: [friend1 * 1, friend2 * 1, friend2 * 1, friend1 * 1]
        })

    }
    static async getActiveFriends({ userId }) {
        return await Promisify({
            sql: `select name,Id,profileImage from user
            where user.Id in 
            (select friend2 from friendship where friend1=?
            and friendship_type=1) and user.websocketid=1 ; `,
            values: [userId * 1]
        })
    }
}