const Promisify = require('../utils/Promisify')
const QueryBuilder = require('../utils/QueryBuilder')
const UserModel = require('../models/User.model')

module.exports = class ConversationModel {
    static async find(participant1, participant2) {
        return Promisify({
            sql: `select * from conversation where
                (participant1=? and participant2=?) or (participant1=? and participant2=?);`,
            values: [participant1, participant2, participant2, participant1]
        })

    }
    static async findById({ Id }) {
        let conversation = await Promisify({
            sql: `select * from conversation where Id=?;`,
            values: [Id]
        })
        return conversation[0]
    }
    static async getNumUnreadMessages({ userId }) {
        try {
            let [{ numUnreadMessages }] = Promisify({
                sql: `select count(*) as numUnreadMessages from conversation where
                receiver=? and isSeen=0;`,
                values: [userId]
            })
            return numUnreadMessages
        } catch (error) {
            return 0
        }

    }
    static async getConversationInfo({ participant1, participant2 }) {
        return Promisify({
            sql: `select * from conversation where
                (participant1=? and participant2=?) or (participant1=? and participant2=?);`,
            values: [participant1, participant2, participant2, participant1]
        })
    }
    static async getConversationList({ userId, pageNumber }) {
        let conversations = await Promisify({
            sql: `select * from conversation where participant1=? or participant2=?
                order by time desc limit ?,20;`,
            values: [userId, userId, pageNumber]
        })
        let promises = []
        for (let conversation of conversations) {
            promises.push(UserModel.findById(userId == conversation.participant2 ? conversation.participant1 : conversation.participant2)
                .then(({ Id, name, profileImage }) => {
                    conversation.participantInfo = { Id, name, profileImage }
                }))
        }
        await Promise.all(promises);
        return conversations
    }

    static async createMessage({ conversationId, sender, body, time, receiver }) {
        Promisify({
            sql: QueryBuilder.insertQuery('message', ['conversationId', 'sender', 'body', 'time']),
            values: [conversationId, sender, body, time]
        })
        Promisify({
            sql: `update conversation set 
                time=?,receiver=?,isSeen=0, last_message=?  where Id=?;`,
            values: [time, receiver, body, conversationId]
        })


    }
    static async createConversation({ participant1, participant2 }) {
        let previouslyCreatedRow = await ConversationModel.find(participant1, participant2)
        if (previouslyCreatedRow.length) {
            return previouslyCreatedRow
        }
        await Promisify({
            sql: QueryBuilder.insertQuery('conversation', ['participant1', 'participant2', 'last_message', 'time', 'is_group_conversation', 'receiver', 'isSeen']),
            values: [participant1, participant2, null, (new Date()) * 1, 0, 0, 0]
        })
        return await ConversationModel.find(participant1, participant2)
    }
    static async getConversationMessages({ conversationId, pageNumber }, currentUserId) {
        Promisify({
            sql: `update user set numUnseenMessages=0
                where Id=?;`,
            values: [currentUserId]
        })
        Promisify({
            sql: `update conversation set isSeen=1
                where Id=?;`,
            values: [conversationId]
        })
        let messages = await Promisify({
            sql: `select * from message 
                where conversationId = ? order by time desc limit ?,20;`,
            values: [conversationId, pageNumber]
        })
        return messages.reverse()
    }
    static async getParticipantInfo({ currentUserId, conversationId }) {
        let conversation = await ConversationModel.findById({ Id: conversationId })
        if (conversation.participant1 == currentUserId) {
            return await UserModel.findById(conversation.participant2)
        }
        else return await UserModel.findById(conversation.participant1)

    }
}