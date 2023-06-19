//
//  RealmModel.swift
//  level
//
//  Created by Владислав Мазуров on 11.06.23.
//

import Foundation
import RealmSwift

class RealmModel: Object {
    
    @Persisted var field1: Double
    @Persisted var field2: Double
    @Persisted var field3: Double
    
    convenience init(field1: Double, field2: Double, field3: Double) {
        self.init()
        self.field1 = field1
        self.field2 = field2
        self.field3 = field3
    }
}
