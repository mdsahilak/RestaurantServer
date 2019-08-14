//
//  Order.swift
//  App
//
//  Created by Muhammed Sahil on 28/06/19.
//

import Vapor
import FluentSQLite

struct Order: Content {
    var id: Int?
    
    var orderingEntity: String
    var orderedIds: [Int]
}

struct OrderHelper: Codable {
    var order: Order
}

// Order on the Server (along with menuItems instead of just Ids)
struct ServerOrder: Content, SQLiteUUIDModel, Migration {
    var id: UUID?
    var date: Date
    var dateString: String
    
    var orderingEntity: String
    var orderedMenuItems: [MenuItem] = []
    
    init(id: UUID?, date: Date, orderingEntity: String, orderedMenuItems: [MenuItem]) {
        self.id = id
        self.date = date
        self.dateString = DateFormatter.localizedString(from: date, dateStyle: .long, timeStyle: .short)
        
        self.orderingEntity = orderingEntity
        self.orderedMenuItems = orderedMenuItems
    }
}

extension ServerOrder: Parameter {}
