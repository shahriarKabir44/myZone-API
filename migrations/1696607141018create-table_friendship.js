const {Table} = require('migratify/templates/Migration.class')
let newTable = new Table("friendship");
newTable.addColumn('friend1','INT')
	.setNullable(false)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addColumn('friend2','INT')
	.setNullable(false)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addColumn('friendship_type','INT')
	.setNullable(false)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addColumn('initiation_time','BIGINT')
	.setNullable(false)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addForeignKey('friend1','user','Id');
newTable.addForeignKey('friend2','user','Id');
module.exports = async () => {
	newTable.create()
}