const {Table} = require('migratify/templates/Migration.class')
let newTable = new Table("post_reactions");
newTable.addColumn('postId','INT')
	.setNullable(true)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addColumn('reactedBy','INT')
	.setNullable(true)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addColumn('time','BIGINT')
	.setNullable(true)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addForeignKey('reactedBy','user','Id');
newTable.addForeignKey('postId','post','Id');
module.exports = async () => {
	return newTable.create()
}