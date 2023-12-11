const {Table} = require('migratify/templates/Migration.class')
let newTable = new Table("user_interests");
newTable.addColumn('userId','INT')
	.setNullable(true)
	 .setDefaultValue('')
	 .setUnique(false)
newTable.addColumn('interestName','MEDIUMTEXT')
	.setNullable(true)
	 .setDefaultValue('')
	 .setUnique(false)
module.exports = async () => {
	return newTable.create()
}