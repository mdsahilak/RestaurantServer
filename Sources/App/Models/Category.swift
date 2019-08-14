//
//  Category.swift
//  App
//
//  Created by Muhammed Sahil on 01/05/19.
//

import Foundation
import Vapor

public struct Category: Content {
    static var salad = "salad"
    static var starter = "starter"
    static var entree = "entree"
    static var dessert = "dessert"
    static var drink = "drink"
    
    static var allCategories: [String] = [Category.salad, Category.starter, Category.entree, Category.dessert, Category.drink]
}
