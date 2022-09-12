const Promisify = require('../utils/Promisify')
const QueryBuilder = require('../utils/QueryBuilder')

module.exports = class CommentModel {
    static async createComment({ commentBody, commentedBy, postId }) {
        const time = (new Date()) * 1
        await Promisify({
            sql: QueryBuilder.insertQuery('post_comments', ['commentBody', 'commentedBy', 'postId', 'time']),
            values: [commentBody, commentedBy, postId, time]
        })
        let [newComment] = await Promisify({
            sql: `select * from post_comments where
                 postId=? and commentedBy=? and time=?`,
            values: [postId, commentedBy, time]
        })
        return newComment
    }
}