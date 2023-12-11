const {Table} = require('migrations/templates/Migration.class')
let newTable = new Table("featured_post");
newTable.addColumn('photoURL','MEDIUMTEXT')
	.setNullable(true)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addColumn('groupId','INT')
	.setNullable(true)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addForeignKey('groupId','featured_post_group','Id');
module.exports = async () => {
	return newTable.create()
}