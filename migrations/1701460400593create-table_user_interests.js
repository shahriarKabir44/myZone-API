const {Table} = require('migratify/templates/Migration.class')
let newTable = new Table("user_interests");
newTable.addColumn('userId','INT')
	.setNullable(true)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addColumn('interestName','TEXT(65536)')
	.setNullable(true)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addForeignKey('userId','user','Id');
module.exports = async () => {
	newTable.create()
}