const {Table} = require('migratify/templates/Migration.class')
let newTable = new Table("featured_post");
newTable.addColumn('photoURL','TEXT(65536)')
	.setNullable(true)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addColumn('groupId','INT')
	.setNullable(true)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addForeignKey('groupId','featured_post_group','Id');
module.exports = async () => {
	newTable.create()
}