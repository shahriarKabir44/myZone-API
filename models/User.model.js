const Promisify = require('../utils/Promisify')
const QueryBuilder = require('../utils/QueryBuilder')
const defaultCoverPhoto = "https://www.al.com/resizer/ILBcdq1ksZC39_8hhnJ_HXsP9j0=/800x0/smart/cloudfront-us-east-1.images.arcpublishing.com/advancelocal/NSDL77J3KJFZXCK3MFWAV7HMUE.JPG"

module.exports = class User {
    static async register(userInfo) {

        await Promisify({
            sql: QueryBuilder.insertQuery('user', ['password', 'name', 'email', 'coverPhoto']),
            values: [userInfo.password, userInfo.name, userInfo.email, defaultCoverPhoto]
        })
        let newUserRow = await Promisify({
            sql: `SELECT * FROM  user where user.Id= (select max(Id) from user) ;`
        })

        return newUserRow[0]
    }
    static async setProfileImage(Id, profileImage) {
        return await Promisify({
            sql: `update user set profileImage="?" where Id=?`,
            values: [profileImage, Id]
        })
    }

    static async login(email, password) {
        let user = await Promisify({
            sql: `select * from user where email="?" and password="?"`,
            values: [email, password]
        })
        if (user.length == 0) {
            return -1
        }
        else return user[0]
    }
    static async getAll() {
        return Promisify({
            sql: `select * from user`
        })
    }
}