//
//  DiaryEntry.swift
//  FODMAPer
//
//  Created by Barry Bryant on 5/6/17.
//  Copyright © 2017 Joopkins. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

public enum SymptomSeverity {
    
    case mild
    case moderate
    case severe
    
    init(with int: Int) {
        if int < 2 {
            self = .mild
        } else if int < 3 {
            self = .moderate
        } else {
            self = .severe
        }
    }
}

public final class DiaryEntry: Object {
    
    dynamic var id = 0
    dynamic var date: Date = Date()
    dynamic var symptomSeverityNumber: Int = 1
    
    var severity: SymptomSeverity {
        return SymptomSeverity(with: symptomSeverityNumber)
    }
    
    public func build(for date: Date, symptomSeverity: Int) {
        self.date = date
        self.id = DiaryEntry.generateId(from: date)
        self.symptomSeverityNumber = symptomSeverity
    }
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    public static func generateId(from date: Date) -> Int {
        let calendar
            = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let id = year + month * 100000 + day * 10000000
        return id
    }
    
}
