class QueryBuilder {
    static insertQuery(tableName, fields) {

        let st = `insert into ${tableName} (${fields.toString()}) values(${new Array(fields.length).fill('?').toString()})`
        return st;

    }
    static getLastInsertedRow(tableName) {
        return `select * from ${tableName} where Id=(select max(Id) from ${tableName})`
    }


}

module.exports = QueryBuilder