const { Table } = require('migratify/templates/Migration.class')

let newTable = new Table("user_interests")
newTable.addColumn('userId', 'int')
newTable.addColumn('interestName', 'TEXT')
newTable.addForeignKey('userId', 'user', 'id')
module.exports = async () => {
    newTable.create()
}