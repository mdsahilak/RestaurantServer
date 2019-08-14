//
//  RestaurantData.swift
//  App
//
//  Created by Muhammed Sahil on 01/05/19.
//

import Foundation

struct RestaurantData {
    static var menuItems: [MenuItem] =
    [
        MenuItem(id: nil, name: "Sphagetti and Meatballs", description: "Seasoned meatballs on top of freshly-made spaghetti. Served with a robust tomato sauce.", price: 9.0, category: Category.entree, imageURL: ImageUrls.sphagettiAndMeatballs, preparationTime: 20),
        MenuItem(id: nil, name: "Grilled Steelhead Trout", description: "Pacific steelhead trout with lettuce, tomato, and red onion.", price: 12.75, category: Category.entree, imageURL: ImageUrls.grilledSteelheadTrout, preparationTime: 15),
        MenuItem(id: nil, name: "Ham and Mushroom Ravioli", description: "House-made ravioli filled with pine nuts, parmesan, ham, and mushrooms. Served over tomato sauce.", price: 8.0, category: Category.starter, imageURL: ImageUrls.hamAndMushroomRavioli, preparationTime: 12),
        MenuItem(id: nil, name: "Chicken Noodle Soup", description: "Chicken simmered alongside yellow onions, carrots, celery, and bay leaves.", price: 3.5, category: Category.starter, imageURL: ImageUrls.chickenNoodleSoup, preparationTime: 5),
        MenuItem(id: nil, name: "Italian Salad", description: "Garlic, red onions, tomatoes, mushrooms, and olives on top of romaine lettuce.", price: 5, category: Category.salad, imageURL: ImageUrls.italianSalad, preparationTime: 7),
        MenuItem(id: nil, name: "Mutton Biryani", description: "Long-grained rice flavored with exotic spices such as saffron is layered with lamb and vegetables cooked in thick gravy", price: 5.0, category: Category.entree, imageURL: ImageUrls.muttonBiryani, preparationTime: 25),
        MenuItem(id: nil, name: "Chocolate Cake", description: "A dark chocolate cake with a hint of chocalate cream.", price: 4.0, category: Category.dessert, imageURL: ImageUrls.chocolateCake, preparationTime: 2),
        MenuItem(id: nil, name: "Red Velvet Cake", description: "Three moist layers of Red Velvet filled with cream cheese and finished with white and dark chocolate shavings and white chocolate drizzle.", price: 7, category: Category.dessert, imageURL: ImageUrls.redVelvetCake, preparationTime: 5),
        MenuItem(id: nil, name: "Mojito", description: "A classic Island drink of fresh lime and sweet muddled mint.", price: 3, category: Category.drink, imageURL: ImageUrls.mojito, preparationTime: 2)
    ]
}
