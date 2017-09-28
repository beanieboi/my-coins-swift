import Fluent
import Vapor

extension Portfolio: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self, closure: { (builder) in
            builder.id()
            builder.string(Portfolio.Properties.apiKey)
        })
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(Portfolio.self)
    }
}

extension Holding: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self) { builder in
            builder.id()
            builder.int(Holding.Properties.portfolioID)
            builder.foreignKey(Holding.Properties.portfolioID, references: "id", on: Portfolio.self)
            builder.string(Holding.Properties.exchangeName)
            builder.string(Holding.Properties.exchangePair)
            builder.double(Holding.Properties.amount)
            builder.double(Holding.Properties.price)
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(Holding.self)
    }
}

