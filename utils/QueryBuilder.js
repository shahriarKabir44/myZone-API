class QueryBuilder {
    static insertQuery(tableName, fields) {

        let st = `insert into ${tableName} (${fields.toString()}) values(${((x) => {
            return new Array(x).fill('?').toString()
        })(fields.length)})`
        return st;

    }
}