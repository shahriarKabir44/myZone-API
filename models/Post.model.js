const Promisify = require('../utils/Promisify')
const QueryBuilder = require('../utils/QueryBuilder')
const fs = require('fs')
module.exports = class Post {
    static async edit({ postId, postBody, imageURLs }) {

        return Promisify({
            sql: `update post set body=?, attached_media=?
                where Id=?;`,
            values: [postBody, imageURLs, postId]
        })
    }
    static async deleteImage({ imageURL }) {
        let dir = 'uploads/' + imageURL;
        new Promise((resolve, reject) => {
            fs.unlink(dir, (err) => {
                if (err) {
                    console.error(err)
                    return
                }
                resolve()
                //file removed
            })
        })
        let featured_groups = await Promisify({
            sql: `select * from featured_post where 
                    photoURL=?`,
            values: [imageURL]
        })
        await Promisify({
            sql: `delete from featured_post where photoURL=?`,
            values: [imageURL]
        })
        for (let group of featured_groups) {
            let { groupId, initialPhoto } = group
            let [{ cnt }] = await Promisify({
                sql: `select count(*) as cnt from featured_post
                    where groupId=?;`,
                values: [groupId]
            })
            if (cnt == 0) {
                await Promisify({
                    sql: `delete from featured_post_group where Id=?;`,
                    values: [groupId]
                })
            }
            else if (initialPhoto == imageURL) {
                let photos = await Promisify({
                    sql: `select * from featured_post where groupId=?;`,
                    values: [groupId]
                })
                await Promisify({
                    sql: `update featured_post_group set initialPhoto=? where Id=?;`,
                    values: [photos[0].photoURL, groupId]
                })
            }
        }
        return
    }
    static async delete({ postId }) {
        await Promise.all([
            (async () => {
                let [{ attached_media }] = await Promisify({
                    sql: `select attached_media from post where Id=?`,
                    values: [postId]
                })
                attached_media = JSON.parse(attached_media)
                for (let imageURL of attached_media) {
                    this.deleteImage({ imageURL })
                }
            })(),
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