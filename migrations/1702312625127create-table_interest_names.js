const {Table} = require('migrations/templates/Migration.class')
let newTable = new Table("interest_names");
newTable.setID('interest_name');
module.exports = async () => {
	return newTable.create()
}