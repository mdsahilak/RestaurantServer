//
//  Bill.swift
//  App
//
//  Created by Muhammed Sahil on 02/07/19.
//

import Foundation
import Vapor
import FluentSQLite

struct Bill: Content, SQLiteUUIDModel, Migration {
    
    var id: UUID?
    var date: Date
    var dateString: String
    
    var orderingEntity: String
    var orderedMenuItems: [MenuItem] = []
    
    var totalBillAmount: Double
    
    init(order: ServerOrder) {
        self.id = order.id
        self.date = order.date
        self.dateString = order.dateString
        
        self.orderingEntity = order.orderingEntity
        self.orderedMenuItems = order.orderedMenuItems
        
        let prices = order.orderedMenuItems.map { $0.price }
        let totalBillAmount = prices.reduce(0) { $0 + $1 }
        
        self.totalBillAmount = totalBillAmount
    }
    
}

extension Bill: Parameter {}
