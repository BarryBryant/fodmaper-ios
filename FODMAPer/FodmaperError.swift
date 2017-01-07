//
//  FodmapError.swift
//  FODMAPer
//
//  Created by Barry Bryant on 1/7/17.
//  Copyright © 2017 Joopkins. All rights reserved.
//

import Foundation

public enum FodmaperError: Error, CustomStringConvertible {
    
    case serializationError
    
    public var description: String {
        switch self {
        case .serializationError:
            return NSLocalizedString("An error occured during serialization.", comment: "Something went wrong serializing JSON.")
        }
    }

}
