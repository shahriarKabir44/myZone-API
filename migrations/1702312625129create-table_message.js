const {Table} = require('migrations/templates/Migration.class')
let newTable = new Table("message");
newTable.addColumn('conversationId','INT')
	.setNullable(true)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addColumn('sender','INT')
	.setNullable(true)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addColumn('body','MEDIUMTEXT')
	.setNullable(true)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addColumn('time','BIGINT')
	.setNullable(true)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addForeignKey('conversationId','conversation','Id');
newTable.addForeignKey('sender','user','Id');
module.exports = async () => {
	return newTable.create()
}