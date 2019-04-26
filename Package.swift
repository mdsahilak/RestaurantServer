// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "RestaurantServer",
    products: [
        .library(name: "RestaurantServer", targets: ["App"]),
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),

        // 🔵 Swift ORM (queries, models, relations, etc) built on SQLite 3.
        .package(url: "https://github.com/vapor/fluent-sqlite.git", from: "3.0.0"),
        
        // 🍃 Leaf, a templating language inspired from swift.
        .package(url: "https://github.com/vapor/leaf.git", from: "3.0.0-rc")
    ],
    targets: [
        .target(name: "App", dependencies: ["FluentSQLite", "Vapor", "Leaf"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)

