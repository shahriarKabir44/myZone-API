const Promisify = require('../utils/Promisify')
const QueryBuilder = require('../utils/QueryBuilder')

module.exports = class Post {
    static async delete({ postId }) {
        await Promise.all([
            Promisify({
                sql: `delete from post_comments where postId=?`,
                values: [postId]
            }),
            Promisify({
                sql: `delete from post_reactions where postId=?`,
                values: [postId]
            }),
            Promisify({
                sql: `delete from notification where
                    relatedSchemaId=? and (type=1 or type=2)`,
                values: [postId]
            })
        ])
        await Promisify({
            sql: `delete from post where Id=?`,
            values: [postId]
        })
        return
    }
    static async createPost(postedBy, postBody) {
        let currentTime = (new Date) * 1
        let currentDay = Math.floor((currentTime) / (24 * 3600 * 1000))
        await Promisify({

            sql: QueryBuilder.insertQuery('post', ['body', 'posted_by', 'posted_day', 'posted_on', 'numReactions', 'numComments']),
            values: [postBody, postedBy, currentDay, currentTime, 0, 0]
        })
        let newPost = await Promisify({
            sql: QueryBuilder.getLastInsertedRow('post')
        })

        return newPost
    }
    static async setPostImage(postId, postImageURLs) {
        return await Promisify({
            sql: `update post set attached_media=? where Id=?`,
            values: [(postImageURLs), postId]
        })
    }


}