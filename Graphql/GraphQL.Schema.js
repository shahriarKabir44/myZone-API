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


const FeaturedAlbumType = new GraphQLObjectType({
    name: 'featured_post_group',
    fields: () => ({
        Id: { type: GraphQLID },
        label: { type: GraphQLString },
        numPosts: { type: GraphQLInt },
        initialPhoto: { type: GraphQLString },
        createdBy: { type: GraphQLID },
        creatorInfo: {
            type: UserType,
            async resolve(parent, args) {
                let [user] = await Promisify({
                    sql: `select * from user where Id=?;`,
                    values: [parent.createdBy]
                })
                return user
            }
        },
        attachedPhotos: {
            type: new GraphQLList(GraphQLString),
            async resolve(parent, args) {
                let photos = await Promisify({
                    sql: `select photoURL from featured_post
                        where groupId = ?;`,
                    values: [parent.Id]
                })
                let photoList = []
                for (let photoObject of photos) {
                    photoList.push(photoObject.photoURL)
                }
                return photoList
            }
        }
    })
})

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
        },
        featuredAlbums: {
            type: new GraphQLList(FeaturedAlbumType),
            async resolve(parent, args) {
                return Promisify({
                    sql: `select * from featured_post_group where
                    createdBy=?;`,
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
        filterPost: {
            type: new GraphQLList(PostType),
            args: {
                query: { type: GraphQLString },
                pageNumber: { type: GraphQLInt }
            },
            resolve: async function (parent, args) {
                return Promisify({
                    sql: `select * from post where 
                        body like ? limit ?,10;`,
                    values: [`%${args.query}%`, args.pageNumber]
                })
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
                pageNumber: { type: GraphQLInt },
                groupType: { type: GraphQLInt }
            },
            async resolve(parent, args) {
                Promisify({
                    sql: `update user set ${args.groupType == 0 ? 'numUnseenNotification' : 'numNewFriendRequests'}=0
                        where Id=?;`,
                    values: [args.receiverId]
                })
                return Promisify({
                    sql: `select * from notification where
                    receiverId =? and ${args.groupType == 0 ? '(type = 1 or type = 2)' : '(type=3 or type =4)'} order by time desc limit ?,10;`,
                    values: [args.receiverId, args.pageNumber]
                })
            }
        },


        getFeaturedAlbum: {
            type: FeaturedAlbumType,
            args: {
                Id: { type: GraphQLID },
            },
            async resolve(parent, args) {
                let [album] = await Promisify({
                    sql: `select * from featured_post_group where
                        Id=?;`,
                    values: [args.Id]
                })
                return album
            }
        },
        getNewFeed: {
            type: new GraphQLList(PostType),
            args: {
                userId: { type: GraphQLID },
                pageNumber: { type: GraphQLInt }
            },
            resolve(parent, args) {
                return Promisify({
                    sql: `select * from post
                        where post.posted_by in 
                        (select friend2 from friendship where friend1=? and friendship_type=1 )
                        or post.posted_by=? 
                        order by posted_on desc limit ?,5;`,
                    values: [args.userId, args.userId, args.pageNumber]
                })
            }
        }
    }
})


module.exports = new GraphQLSchema({
    query: RootQueryType
})