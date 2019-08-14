//
//  MenuItem.swift
//  App
//
//  Created by Muhammed Sahil on 27/04/19.
//

import Foundation
import Vapor
import FluentSQLite

struct MenuItem: Content, SQLiteModel, Migration {
    var id: Int?
    var name: String
    var description: String
    var price: Double // in dollars
    var category: String
    var imageURL: URL
    var preparationTime: Int  // in minutes
    
}

extension MenuItem: Parameter {}
