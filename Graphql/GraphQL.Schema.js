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

const UserModel = require('../models/User.model')
const PostModel = require('../models/Post.model')
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

        }
    })
})