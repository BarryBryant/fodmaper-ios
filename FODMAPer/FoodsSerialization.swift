//
//  FoodRepository.swift
//  FODMAPer
//
//  Created by Barry Bryant on 1/7/17.
//  Copyright © 2017 Joopkins. All rights reserved.
//

import Foundation

final class FoodsSerialization {
    
    private enum propertyKey: String, JSONPropertyKey {
        case food
    }
    
    private static let rootPath = Bundle.main.url(forResource: "fodmaps", withExtension: "json")
    
    static func allFoods() throws -> Array<Food> {
        guard let rootPath = FoodsSerialization.rootPath else {
            throw FodmaperError.serializationError
        }
        let data = try Data(contentsOf: rootPath)
        return try FoodsSerialization.foods(with: data)
    }
    
    static func foods(with data: Data) throws -> Array<Food> {
        let dictionary = try JSONSerialization.jsonDictionary(with: data)
        return try foods(with: dictionary)
    }
    
    static func foods(with jsonDictionary: JSONDictionary) throws -> Array<Food> {
        guard let foods: [JSONDictionary] = jsonDictionary.jsonValue(propertyKey.food) else {
            throw FodmaperError.serializationError
        }
        
        return try foods.flatMap(FoodSerialization.food(with: ))
    }

}
