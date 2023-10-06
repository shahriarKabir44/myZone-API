const { Table } = require('migratify/templates/Migration.class')
let newTable = new Table("featured_post");
newTable.addColumn('photoURL', 'TEXT');
newTable.addColumn('groupId', 'int');
newTable.addForeignKey('groupId', 'featured_post_group', 'Id');
module.exports = async () => {
	newTable.create()
}