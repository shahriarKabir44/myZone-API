const {Table} = require('migratify/templates/Migration.class')
let newTable = new Table("featured_post");
newTable.setID('photoURL');
newTable.setID('groupId');
newTable.addForeignKey('groupId','featured_post_group','Id');
module.exports = async () => {
	newTable.create()
}