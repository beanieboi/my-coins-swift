import PostgreSQLProvider

final class Portfolio: Model {
    let storage = Storage()
    
    public struct Properties {
        public static let apiKey = "api_key"
    }
    
    let api_key: String
    
    /// Creates a new Portfolio
    init(api_key: String) {
        self.api_key = api_key
    }
    
    /// Initializes from database row
    init(row: Row) throws {
        self.api_key = try row.get(Properties.apiKey)
    }
    
    // Serializes to the database
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Properties.apiKey, api_key)
        return row
    }
}

extension Portfolio: Timestampable { }

extension Portfolio: JSONRepresentable {
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        
        let summary = try Holding.database?.raw("SELECT exchange_pair, SUM(amount), sum(price) FROM holdings WHERE portfolio_id=1 GROUP BY exchange_pair;")
        
        try print(summary!.get("exchange_pair"))
        
        return json
    }
}

extension Portfolio: ResponseRepresentable { }
