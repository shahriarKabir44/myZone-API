const {Table} = require('migratify/templates/Migration.class')
let newTable = new Table("post_comments");
newTable.setID('Id');
newTable.addColumn('commentBody','MEDIUMTEXT')
	.setNullable(true)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addColumn('commentedBy','INT')
	.setNullable(true)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addColumn('postId','INT')
	.setNullable(true)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addColumn('time','BIGINT')
	.setNullable(true)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addForeignKey('commentedBy','user','Id');
newTable.addForeignKey('postId','post','Id');
module.exports = async () => {
	return newTable.create()
}