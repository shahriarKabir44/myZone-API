const Promisify = require('../utils/Promisify')
const QueryBuilder = require('../utils/QueryBuilder')

module.exports = class NotificationModel {
    static async create({ senderId, receiverId, body, relatedSchemaId, time, type }) {
        await Promisify({
            sql: QueryBuilder.insertQuery('notification', ['senderId', 'receiverId', 'body', 'relatedSchemaId', 'time', 'type']),
            values: [senderId, receiverId, body, relatedSchemaId, time, type]
        })
        Promisify({
            sql: `update user set numUnseenNotification=numUnseenNotification+1
                where user.Id=?;`,
            values: [receiverId]
        })
        let [newNotification] = await Promisify({
            sql: `select * from notification where
            senderId=?   and receiverId=? and  body=? and  relatedSchemaId=? and  time=? and type=?;`,
            values: [senderId, receiverId, body, relatedSchemaId, time, type]
        })
        return newNotification
    }

}