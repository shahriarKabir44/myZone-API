const promisify = require('../utils/Promisify')
const QueryBuilder = require('../utils/QueryBuilder')

module.exports = class Post {
    static async createPost(postedBy, postBody) {
        let currentTime = (new Date) * 1
        let currentDay = Math.floor((currentTime) / (24 * 3600 * 1000))
        await promisify({

            sql: QueryBuilder.insertQuery('post', ['body', 'posted_by', 'posted_day', 'posted_on']),
            values: [postBody, postedBy, currentDay, currentTime]
        })
        return await promisify({
            sql: QueryBuilder.getLastInsertedRow('post')
        })[0]
    }
    static async setPostImage(postId, postImageURLs) {
        return await promisify({
            sql: `update post set attached_media=? where Id=?`,
            values: [(postImageURLs), postId]
        })
    }
}