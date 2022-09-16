const Promisify = require('../utils/Promisify')
const QueryBuilder = require('../utils/QueryBuilder')


module.exports = class ConversationModel {
    static async find(participant1, participant2) {
        return Promisify({
            sql: `select * from converstion where
                (participant1=? and participant2=?) or (participant1=? and participant2=?);`,
            values: [participant1, participant2, participant2, participant1]
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
}