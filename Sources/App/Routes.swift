import Vapor

extension Droplet {
    func setupRoutes() throws {
        try resource("portfolio", PortfolioController.self)
    }
}
