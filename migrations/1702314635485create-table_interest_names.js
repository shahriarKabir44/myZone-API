const {Table} = require('migratify/templates/Migration.class')
let newTable = new Table("interest_names");
newTable.addColumn('interest_name','VARCHAR(255)')
	.setNullable(true)
	 .setDefaultValue('')
	 .setUnique(false)
module.exports = async () => {
	return newTable.create()
}