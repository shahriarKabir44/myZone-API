const Promisify = require('../utils/Promisify')
const QueryBuilder = require('../utils/QueryBuilder')
module.exports = class InterestModel {
    static async getUserInterests(userId) {
        return Promisify({
            sql: `select * from user_interests
                where userId=?;`,
            values: [userId]
        })
    }
    static async otherInterests(userId) {
        return Promisify({
            sql: `select interest_name from interest_names
                where interest_name not in (
                    select interestName from user_interests
                    where userId=?
                ) ;`,
            values: [userId]
        })
    }
    static async addInterest({ userId, interestName }) {
        return Promisify({
            sql: `insert into user_interests
                (userId, interestName)
                values (?,?)`,
            values: [userId, interestName]
        })
    }
    static async removeInterest(userId, interestName) {
        return Promisify({
            sql: `delet from user_interests where userId = ? and interestName = ?;`,
            values: [userId, interestName]
        });
    }
    static async createInterest({ interest_name }) {
        return Promisify({
            sql: QueryBuilder.insertQuery('interest_names', ['interest_name']),
            values: [interest_name]
        })
    }
}