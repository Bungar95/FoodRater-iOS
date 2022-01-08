//
//  FoodRaterRepository.swift
//  FoodRater
//
//  Created by Borna Ungar on 03.01.2022..
//

import Foundation
class FoodRaterRepositoryImpl: FoodRaterRepository {
    
    func fetchList() -> [Item] {
        let list = Database.singleton.fetch()
        print("List fetched.")
        return Array(list)
    }
    
    func addUpdateToList(name: String, rating: Int, imagePath: Data, comment: String?){
        Database.singleton.createOrUpdate(name: name, rating: rating, imagePath: imagePath, comment: comment)
        print("Task added/updated.")
    }
    
    func deleteFromList(itemId: Int){
        let taskId = itemId
        Database.singleton.delete(primaryKey: taskId)
        print("Task deleted.")
    }
    
}

protocol FoodRaterRepository: AnyObject {
    
    func fetchList() -> [Item]
    func addUpdateToList(name: String, rating: Int, imagePath: Data, comment: String?)
    func deleteFromList(itemId: Int)
}
