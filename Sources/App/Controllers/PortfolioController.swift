import Vapor
import HTTP

final class PortfolioController: ResourceRepresentable {
    //    typealias Model = Portfolio
    
    func makeResource() -> Resource<Portfolio> {
        return Resource(
            index: index
        )
    }
    
    func index(_ req: Request) throws -> ResponseRepresentable {
        guard let portfolio = try Portfolio.makeQuery().filter("api_key", "1234").first()
            else {
                return "{}"
        }
        return try portfolio.makeJSON()
    }
}

extension PortfolioController: EmptyInitializable { }
