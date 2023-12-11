const {Table} = require('migratify/templates/Migration.class')
let newTable = new Table("group_conversation_members");
newTable.addColumn('groupId','INT')
	.setNullable(true)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addColumn('memberId','INT')
	.setNullable(true)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addForeignKey('groupId','group_conversation','Id');
newTable.addForeignKey('memberId','user','Id');
module.exports = async () => {
	return newTable.create()
}