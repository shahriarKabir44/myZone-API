const Promisify = require('../utils/Promisify')
const QueryBuilder = require('../utils/QueryBuilder')
const UserModel = require('../models/User.model')

module.exports = class ConversationModel {
    static async find(participant1, participant2) {
        return Promisify({
            sql: `select * from converstion where
                (participant1=? and participant2=?) or (participant1=? and participant2=?);`,
            values: [participant1, participant2, participant2, participant1]
        })

    }
    static async findById(Id) {
        return Promisify({
            sql: `select * from converstion where
                Id=?`,
            values: [Id]
        })
    }
    static async createConversation({ participant1, participant2 }) {
        let previouslyCreatedRow = await ConversationModel.find(participant1, participant2)
        if (previouslyCreatedRow.length) {
            return previouslyCreatedRow
        }
        await Promisify({
            sql: QueryBuilder.insertQuery('converstion', ['participant1', 'participant2', 'last_message', 'time', 'is_group_conversation']),
            values: [participant1, participant2, "", (new Date()) * 1, 0]
        })
        return await ConversationModel.find(participant1, participant2)
    }
    static async getConversationMessages({ conversationId, pageNumber }) {
        return Promisify({
            sql: `select * from message 
                where conversationId = ? order by time desc limit ?,20;`,
            values: [conversationId, pageNumber]
        })
    }
    static async getParticipantInfo({ currentUserId, conversationId }) {
        let [conversation] = await ConversationModel.findById(conversationId)
        if (conversation.participant1 == currentUserId) {
            return await UserModel.findById(conversation.participant2)
        }
        else return await UserModel.findById(conversation.participant1)

    }
}