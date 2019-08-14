//
//  PreparationTimeCalculator.swift
//  App
//
//  Created by Muhammed Sahil on 12/05/19.
//

import Foundation
import Vapor

struct AddNewItemHelper: Content {
    var newMenuItem: MenuItem
}

struct OrderSuccess: Content {
    var orderID: UUID?
    var prepTime: Int
}
