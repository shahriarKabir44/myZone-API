const {Table} = require('migratify/templates/Migration.class')
let newTable = new Table("message");
newTable.addColumn('conversationId','INT')
	.setNullable(false)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addColumn('sender','INT')
	.setNullable(false)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addColumn('body','TEXT(65536)')
	.setNullable(false)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addColumn('time','BIGINT')
	.setNullable(false)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addForeignKey('conversationId','conversation','Id');
newTable.addForeignKey('sender','user','Id');
module.exports = async () => {
	newTable.create()
}