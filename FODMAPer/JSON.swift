//
//  JSON.swift
//  FODMAPer
//
//  Created by Barry Bryant on 1/7/17.
//  Copyright © 2017 Joopkins. All rights reserved.
//

import Foundation

public typealias JSONDictionary = Dictionary<String, AnyObject>
public typealias JSONArray = Array<AnyObject>

public enum JSONError: Error {
    case unexpectedContainerType
    case unexpectedPropertyType
}

public protocol JSONPropertyKey {
    
    var rawValue: String { get }
    
}

extension String: JSONPropertyKey {
    
    public var rawValue: String {
        return self
    }
    
}

extension Dictionary where Key: ExpressibleByStringLiteral, Value: AnyObject {
    
    public func jsonValue<T>(_ key: JSONPropertyKey) -> T? {
        guard let valueKey = key.rawValue as? Key else {
            return nil
        }
        return self[valueKey] as? T
    }
    
    public func url(_ key: JSONPropertyKey) -> URL? {
        guard let urlString: String = jsonValue(key) else {
            return nil
        }
        return URL(string: urlString)
    }
    
}

extension JSONSerialization {
    
    public static func jsonDictionary(with data: Data) throws -> JSONDictionary {
        guard let jsonDictionary = try jsonObject(with: data, options: []) as? JSONDictionary else {
            throw JSONError.unexpectedContainerType
        }
        return jsonDictionary
    }
    
    public static func jsonArray(with data: Data) throws -> JSONArray {
        guard let jsonArray = try jsonObject(with: data, options: []) as? JSONArray else {
            throw JSONError.unexpectedContainerType
        }
        return jsonArray
    }
    
}
