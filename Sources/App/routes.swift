import Vapor
import Fluent
import FluentSQLite
import Routing


/// Register your application's routes here.
public func routes(_ router: Router) throws {
    
    // Sample Data Initialisation
    router.post("/init") { req -> String in
        for item in RestaurantData.menuItems {
            item.save(on: req)
        }
        
        return "Init protocol called. Initialised database with sample Menu Items."
    }
    
    /// MARK: HOME Route
    
    router.get { req -> Future<View> in
        return try req.view().render("home")
    }
    
    /// MARK: COMMON Routes
    
    router.get("/categories") { req -> String in
        let dict: [String: [String]] = ["categories": Category.allCategories]
        let jsonDict = try JSONEncoder().encode(dict)
        
        return String(data: jsonDict, encoding: .utf8)!
    }
    
    router.get("menu") {req -> Future<String> in
        let allMenuItemsReturnString = MenuItem.query(on: req).all().map({ menuItems -> String in
            let dict = ["items": menuItems]
            let jsonDict = try JSONEncoder().encode(dict)
            return String(data: jsonDict, encoding: .utf8)!
        })
        
        return allMenuItemsReturnString
    }
    
    router.get("menu", String.parameter) { req -> Future<String> in
        let wantedCategory: String = try req.parameters.next()
        
        let returnString = MenuItem.query(on: req).filter(\.category == wantedCategory).all().map { menuitems -> String in
            let dict = ["items": menuitems]
            let jsonDict = try JSONEncoder().encode(dict)
            return String(data: jsonDict, encoding: .utf8)!
        }
        
        return returnString
    }
    
    /// MARK: CLIENT Routes
    
    router.post("order") { req -> Future<String> in
        let jsonBody = req.http.body
        let data = jsonBody.data!
        
        let orderHelper = try JSONDecoder().decode(OrderHelper.self, from: data)
        let order = orderHelper.order
        
        let orderingEntity = order.orderingEntity
        let orderedIds = order.orderedIds
        
        let returnString = MenuItem.query(on: req).filter(\.id ~~ orderedIds).all().flatMap { menuItems -> Future<String> in
            
            var totalTimesForPreparation: [Int] = []
            var orderedItems: [MenuItem] = []
            
            for orderedId in orderedIds {
                for menuItem in menuItems {
                    if menuItem.id == orderedId {
                        totalTimesForPreparation.append(menuItem.preparationTime)
                        orderedItems.append(menuItem)
                    }
                }
            }
            
            let approxPrepTime = totalTimesForPreparation.max() ?? 0
            
            let newServerOrder = ServerOrder(id: nil, date: Date(), orderingEntity: orderingEntity, orderedMenuItems: orderedItems)
            
            return newServerOrder.create(on: req).map { savedOrder -> String in
                
                let orderSucess = OrderSuccess(orderID: savedOrder.id, prepTime: approxPrepTime)
                let returnData = orderSucess
                let returnJson = try JSONEncoder().encode(returnData)
                
                return String(data: returnJson, encoding: .utf8)!
            }
        }
        
        return returnString
    }
    
    
    /// MARK: KITCHEN Routes
    
    router.get("/kitchen") {req -> Future<View> in
        return ServerOrder.query(on: req).sort(\.date, .ascending).all().flatMap { serverOrders in
            let context = ["serverOrders": serverOrders]
            
            return try req.view().render("Kitchen", context)
        }
        
    }
    
    router.get("/kitchen/delete", ServerOrder.parameter) { req -> Future<Response> in
        let order = try req.parameters.next(ServerOrder.self)
        return order.delete(on: req).flatMap { order in
            let bill = Bill(order: order)
            return bill.create(on: req).map { _ in
                req.redirect(to: "/kitchen")
            }
        }
    }
    
    router.get("/kitchen/reload") { req -> Response in
        req.redirect(to: "/kitchen")
    }
    
    
    /// MARL: BILLING Routes
    
    router.get("/billing") { req -> Future<View> in
        return Bill.query(on: req).sort(\.date, .descending).all().flatMap { bills in
            let context: [String: [Bill]] = ["bills": bills]
            return try req.view().render("Bills", context)
        }
    }
    
    router.get("/billing", Bill.parameter) { req -> Future<View> in
        return try req.parameters.next(Bill.self).flatMap { bill in
            let context: [String: Bill] = ["bill": bill]
            return try req.view().render("bill", context)
        }
    }
    
    router.get("/billing/reload") { req -> Response in
        req.redirect(to: "/billing")
    }
    
    
    /// MARK: ADMINISTRATOR Routes
    
    // POST method for both adding and editing menu items (if an id is present, it adds otherwise edits)
    router.post("/admin/add") { req -> Future<String> in
        let jsonBody = req.http.body
        let jsonData = jsonBody.data
        //print(jsonBody)
        
        let data = jsonData!
        let newItemHelper = try JSONDecoder().decode(AddNewItemHelper.self, from: data)
        let newMenuItem = newItemHelper.newMenuItem
        
        let returnString = newMenuItem.save(on: req).map { addedMenuItem -> String in
            
            let returnDict: [String: MenuItem] = ["newMenuItem": addedMenuItem]
            let returnJson = try JSONEncoder().encode(returnDict)
            
            return String(data: returnJson, encoding: .utf8)!
        }
        
        return returnString
    }
    
    router.get("/admin/delete", MenuItem.parameter) { req -> Future<String> in
        let item = try req.parameters.next(MenuItem.self)
        
        let returnString = item.delete(on: req).map { deletedItem in
            return "DELETED"
        }
        
        return returnString
    }
    
}

