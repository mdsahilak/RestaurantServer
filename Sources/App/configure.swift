import FluentSQLite
import Vapor
import Leaf

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    
    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)
    
    // Leaf Setup
    try services.register(LeafProvider())
    config.prefer(LeafRenderer.self, for: ViewRenderer.self)
    
    // Database setup
    try services.register(FluentSQLiteProvider())
    let sqliteDB = try SQLiteDatabase(storage: .memory)
    
    var databases = DatabasesConfig()
    databases.add(database: sqliteDB, as: .sqlite)
    services.register(databases)
    
    // Migration setup
    var migrationConfig = MigrationConfig()
    migrationConfig.add(model: MenuItem.self, database: .sqlite)
    migrationConfig.add(model: ServerOrder.self, database: .sqlite)
    migrationConfig.add(model: Bill.self, database: .sqlite)
    services.register(migrationConfig)
    
    // Edit hostname
    let myServerConfig = NIOServerConfig.default(hostname: "0.0.0.0")
    services.register(myServerConfig)
    
}
