const graphql = require('graphql')
const {
    GraphQLObjectType,
    GraphQLString,
    GraphQLSchema,
    GraphQLID,
    GraphQLInt,
    GraphQLList,
    GraphQLNonNull,
    GraphQLFloat,


} = graphql;

const Promisify = require('../utils/Promisify')
const UserType = new GraphQLObjectType({
    name: 'user',
    fields: () => ({
        Id: { type: GraphQLID },

        email: { type: GraphQLString },
        profileImage: { type: GraphQLString },
        coverPhoto: { type: GraphQLString },
        numFriends: { type: GraphQLInt },
        websocketid: { type: GraphQLString },
        serviceworker_id: { type: GraphQLString },
        name: { type: GraphQLString },
        createdPosts: {
            type: new GraphQLList(PostType),
            async resolve(parent, args) {
                return Promisify({
                    sql: `select * from post
                    where post.posted_by=?
                    order by Id desc limit 0,5;`,
                    values: [parent.Id]
                })
            }
        }
    })
})

const CommentType = new GraphQLObjectType({
    name: 'comment',
    fields: () => ({
        commentId: { type: GraphQLID },
        commentBody: { type: GraphQLString },
        commenterId: { type: GraphQLID },
        postId: { type: GraphQLID },
        time: { type: GraphQLFloat },
        commenterName: { type: GraphQLString },
        commenterProfileImage: { type: GraphQLString }
    })
})

const PostType = new GraphQLObjectType({
    name: 'post',
    fields: () => ({
        Id: { type: GraphQLID },
        body: { type: GraphQLString },
        attached_media: { type: GraphQLString },
        posted_by: { type: GraphQLID },
        posted_day: { type: GraphQLInt },
        posted_on: { type: GraphQLFloat },
        numReactions: { type: GraphQLInt },
        numComments: { type: GraphQLInt },
        creatorInfo: {
            type: UserType,
            async resolve(parent, args) {
                let user = await Promisify({
                    sql: `select * from user where Id=?`,
                    values: [parent.posted_by]
                })
                return user[0]
            }
        },
        getFirstComments: {
            type: new GraphQLList(CommentType),
            async resolve(parent, args) {
                return await Promisify({
                    sql: `select post_comments.commentBody, post_comments.time, user.name as commenterName, user.Id as commenterId,user.profileImage as commenterProfileImage,post_comments.Id as commentId
                    from post_comments,user 
                    where post_comments.commentedBy=user.Id and post_comments.postId=? order by post_comments.Id desc limit 0,5;`,
                    values: [parent.Id]
                })
            }
        }
    })
})

const NotificationType = new GraphQLObjectType({
    name: 'notification',
    fields: () => ({
        Id: { type: GraphQLID },
        senderId: { type: GraphQLID },
        receiverId: { type: GraphQLID },
        body: { type: GraphQLString },
        time: { type: GraphQLFloat },
        relatedSchemaId: { type: GraphQLID },
        type: { type: GraphQLString },
        relatedSchemaInfo: {
            type: GraphQLString,
            async resolve(parent, args) {
                if (parent.type === 1 || parent.type === 2) {
                    let [post] = await Promisify({
                        sql: `select * from post where Id=?;`,
                        values: [parent.relatedSchemaId]
                    })
                    return JSON.stringify(post)
                }
            }
        },
        senderInfo: {
            type: UserType,
            async resolve(parent, args) {
                let [user] = await Promisify({
                    sql: `select * from user where Id=?`,
                    values: [parent.senderId]
                })
                return user
            }
        }
    })
})


const RootQueryType = new GraphQLObjectType({
    name: 'rootQuery',
    fields: {
        findPostById: {
            type: PostType,
            args: {
                Id: { type: GraphQLID }
            },
            async resolve(parent, args) {
                let post = await Promisify({
                    sql: `select * from post where Id=?`,
                    values: [args.Id]
                })
                return post[0]
            }
        },
        findUserById: {
            type: UserType,
            args: {
                Id: { type: GraphQLID }
            },
            async resolve(parent, args) {
                let post = await Promisify({
                    sql: `select * from user where Id=?`,
                    values: [args.Id]
                })
                return post[0]
            }
        },
        getNotifications: {
            type: new GraphQLList(NotificationType),
            args: {
                receiverId: { type: GraphQLID },
                pageNumber: { type: GraphQLInt }
            },
            async resolve(parent, args) {
                return Promisify({
                    sql: `select * from notification where
                    receiverId =? order by time desc limit ?,10;`,
                    values: [args.receiverId, args.pageNumber]
                })
            }
        }
    }
})


module.exports = new GraphQLSchema({
    query: RootQueryType
})