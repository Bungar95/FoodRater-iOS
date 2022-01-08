//
//  Database.swift
//  FoodRater
//
//  Created by Borna Ungar on 03.01.2022..
//

import Foundation
import RealmSwift

class Database {
    
    static let singleton = Database()
    private init() {}
    
    func createOrUpdate(name: String, rating: Int, imagePath: Data, comment: String?) -> (Void) {
        
        let realm = try! Realm()
        
        var id: Int? = 1
        
        if let lastEntity = realm.objects(Item.self).last {
            id = lastEntity.id + 1
        }
        
        let itemEntity = Item()
        itemEntity.id = id!
        itemEntity.name = name
        itemEntity.rating = rating
        itemEntity.imagePath = imagePath
        itemEntity.createdAt = Date()
        
        if let itemComment = comment {
            itemEntity.comment = itemComment
        }
        
        try! realm.write {
            realm.add(itemEntity, update: .all)
        }
        
    }
    
    func fetch() -> (Results<Item>) {
        
        let realm = try! Realm()
        
        let itemResults = realm.objects(Item.self)
        
        return itemResults
    }
    
    func delete(primaryKey: Int) -> (Void) {
        
        let realm = try! Realm()
        
        if let itemEntity = realm.object(ofType: Item.self, forPrimaryKey: primaryKey) {
            try! realm.write{
                realm.delete(itemEntity)
            }
        }
        
    }
}
