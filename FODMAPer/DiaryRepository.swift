//
//  DiaryRepository.swift
//  FODMAPer
//
//  Created by Barry Bryant on 5/6/17.
//  Copyright © 2017 Joopkins. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

public protocol DiaryStoring {
    
    func getDiaryEntryForDate(_ date: Date) -> DiaryEntry?
    func storeDiaryEntry(entry: DiaryEntry) throws
}

final class DiaryRepository: DiaryStoring {
    
    let realm: Realm
    
    public init?() {
        do {
            self.realm = try Realm()
        } catch {
            return nil
        }
    }
    
    func getDiaryEntryForDate(_ date: Date) -> DiaryEntry? {
        let id = DiaryEntry.generateId(from: date)
        guard let entry = realm.object(ofType: DiaryEntry.self, forPrimaryKey: id)
        else {
            return nil
        }
        return entry
    }
    
    func storeDiaryEntry(entry: DiaryEntry) throws {
        try realm.write {
            realm.add(entry)
        }
    }
    

}
