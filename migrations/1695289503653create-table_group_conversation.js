const {Table} = require('migratify/templates/Migration.class')
let newTable = new Table("group_conversation");
newTable.setID('Id');
newTable.addColumn('created_by','INT')
	.setNullable(false)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addColumn('room_name','VARCHAR(45)')
	.setNullable(false)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addColumn('group_name','VARCHAR(45)')
	.setNullable(false)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addForeignKey('created_by','user','Id');
module.exports = async () => {
	newTable.create()
}