const Promisify = require('../utils/Promisify')

module.exports = class FeaturingModel {
    static async getFeaturedAlbums(createdBy) {
        return await Promisify({
            sql: `SELECT * FROM myzone.featured_post_group where createdBy=?; `,
            values: [createdBy]
        })
    }
    static async createFeaturedAlbum({ label, createdBy }) {
        await Promisify({
            sql: `INSERT INTO myzone.featured_post_group (label, createdBy) VALUES (?,?);`,
            values: [label, createdBy]
        })
        let [newAlbum] = await Promisify({
            sql: `SELECT * FROM myzone.featured_post_group where createdBy=? and label=?;`,
            values: [createdBy, label]
        })
        return newAlbum
    }
    static async addPhotoToFeaturedAlbum({ groupId, photoURL }) {
        return await Promisify({
            sql: `INSERT INTO myzone.featured_post (groupId, photoURL) VALUES (?,?);`,
            values: [groupId, photoURL]
        })
    }
    static async removePhotoFromFeaturedAlbum(albumName, photo) { }
}