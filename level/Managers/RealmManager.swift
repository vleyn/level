//
//  RealmManager.swift
//  level
//
//  Created by Владислав Мазуров on 11.06.23.
//

import Foundation
import RealmSwift

protocol RealmManagerProtocol {
    var realm: Realm { get }
    func realmWrite(object: RealmModel)
    func realmUpdate(data: Double, index: Int)
    func realmDelete(index: Int)
    func realmClear()
    func realmGetObjects() -> RealmSwift.Results<RealmModel>
}

class RealmManager: RealmManagerProtocol {
    
    var realm = try! Realm()
    
    lazy var objects: RealmSwift.Results<RealmModel> = {
        realm.objects(RealmModel.self)
    }()
    
    func realmWrite(object: RealmModel) {
        let info = RealmModel(field1: object.field1, field2: object.field2, field3: object.field3)
        do {
            try realm.write {
                realm.add(info)
            }
        } catch {
            print("Error when adding savings")
        }
    }
    
    func realmUpdate(data: Double, index: Int) {
        let field = objects[index]
        do {
            try realm.write {
                field.field1 = data
            }
        } catch {
            print("Error when changing savings")
        }
    }
    
    func realmDelete(index: Int) {
        let objectForDelete = objects[index]
        do {
            try realm.write {
                realm.delete(objectForDelete)
            }
        } catch {
            print("Error deleting object: \(error)")
        }
    }
    
    func realmClear() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print("Error when clear database")
        }
    }
    
    func realmGetObjects() -> RealmSwift.Results<RealmModel> {
        realm.objects(RealmModel.self)
    }
    
}

