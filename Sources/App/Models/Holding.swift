import PostgreSQLProvider

final class Holding: Model {
    public struct Properties {
        public static let portfolioID = "portfolio_id"
        public static let exchangeName = "exchange_name"
        public static let exchangePair = "exchange_pair"
        public static let amount = "amount"
        public static let price = "price"
    }
    
    let storage = Storage()
    let portfolio_id: Identifier?
    let exchange_name: String
    let exchange_pair: String
    let amount: Double
    let price: Double
    
    /// Creates a new Holding
    init(portfolio: Portfolio, exchange_name: String, exchange_pair: String, amount: Double, price: Double) {
        self.portfolio_id = portfolio.id
        self.exchange_name = exchange_name
        self.exchange_pair = exchange_pair
        self.amount = amount
        self.price = price
    }
    
    /// Initializes from database row
    init(row: Row) throws {
        self.portfolio_id = try row.get(Properties.portfolioID)
        self.exchange_name = try row.get(Properties.exchangeName)
        self.exchange_pair = try row.get(Properties.exchangePair)
        self.amount = try row.get(Properties.amount)
        self.price = try row.get(Properties.price)
    }
    
    // Serializes to the database
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Properties.portfolioID, portfolio_id)
        try row.set(Properties.exchangeName, exchange_name)
        try row.set(Properties.exchangePair, exchange_pair)
        try row.set(Properties.amount, amount)
        try row.set(Properties.price, price)
        return row
    }
}

extension Holding: Timestampable { }
