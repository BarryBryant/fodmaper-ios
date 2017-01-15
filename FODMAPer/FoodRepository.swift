//
//  FodmapRepository.swift
//  FODMAPer
//
//  Created by Barry Bryant on 1/7/17.
//  Copyright © 2017 Joopkins. All rights reserved.
//

import Foundation

final class FoodRepository {
    
    var foods: Array<Food>!
    
    init() {
        do {
            self.foods = try FoodsSerialization.allFoods()
        } catch {
            print("Sorrah")
        }
    }
    
    public func getAllFoods() -> Array<Food> {
        return self.foods.sorted {
            $0.name < $1.name
        }
    }
    
    public func getFodmaps() -> Array<Food> {
        return self.foods.filter { $0.f == 2 }
    }
    
    public func getModerates() -> Array<Food> {
        return self.foods.filter { $0.f == 1 }
    }
    
    public func getFruits() -> Array<Food> {
        return self.foods.filter { $0.f == -1 }
    }
    
    public func getVegitables() -> Array<Food> {
        return self.foods.filter { $0.f == -2 }
    }
    
    public func getAnimalProducts() -> Array<Food> {
        return self.foods.filter { $0.f == -3 }
    }
    
    public func getGrains() -> Array<Food> {
        return self.foods.filter { $0.f == -4 }
    }
    
    public func getSeasonings() -> Array<Food> {
        return self.foods.filter { $0.f == -5 }
    }
    
    
}
