//
//  FodmapSerialization.swift
//  FODMAPer
//
//  Created by Barry Bryant on 1/7/17.
//  Copyright © 2017 Joopkins. All rights reserved.
//

import Foundation

public final class FoodSerialization {

    private enum propertyKey: String, JSONPropertyKey {
        case name
        case f
        case o
        case d
        case m
        case p
    }
    
    static func food(with jsonDictionary: JSONDictionary) throws -> Food {
        return Food(name: jsonDictionary.jsonValue(propertyKey.name)!,
                        f: jsonDictionary.jsonValue(propertyKey.f)!,
                        o: jsonDictionary.jsonValue(propertyKey.o)!,
                        d: jsonDictionary.jsonValue(propertyKey.d)!,
                        m: jsonDictionary.jsonValue(propertyKey.m)!,
                        p: jsonDictionary.jsonValue(propertyKey.p)!)
    }
    
}
