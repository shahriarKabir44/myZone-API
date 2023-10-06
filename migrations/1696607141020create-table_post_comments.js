const {Table} = require('migratify/templates/Migration.class')
let newTable = new Table("post_comments");
newTable.setID('Id');
newTable.addColumn('commentBody','TEXT(65536)')
	.setNullable(false)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addColumn('commentedBy','INT')
	.setNullable(false)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addColumn('postId','INT')
	.setNullable(false)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addColumn('time','BIGINT')
	.setNullable(false)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addForeignKey('commentedBy','user','Id');
newTable.addForeignKey('postId','post','Id');
module.exports = async () => {
	newTable.create()
}