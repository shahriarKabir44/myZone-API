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
            sql: `select post_comments.commentBody, post_comments.time, user.name as commenterName, user.Id as commenterId,user.profileImage as commenterProfileImage,post_comments.Id as commentId
            from post_comments,user 
            where post_comments.commentedBy=user.Id and post_comments.postId=? and post_comments.commentedBy=? and time=?;`,
            values: [postId, commentedBy, time]
        })
        return newComment
    }
}