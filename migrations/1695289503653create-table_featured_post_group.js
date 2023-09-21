const {Table} = require('migratify/templates/Migration.class')
let newTable = new Table("featured_post_group");
newTable.setID('Id');
newTable.addColumn('label','VARCHAR(45)')
	.setNullable(false)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addColumn('createdBy','INT')
	.setNullable(false)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addColumn('numPosts','INT(10) UNSIGNED ZEROFILL')
	.setNullable(true)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addColumn('initialPhoto','TEXT(65536)')
	.setNullable(true)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addForeignKey('createdBy','user','Id');
module.exports = async () => {
	newTable.create()
}