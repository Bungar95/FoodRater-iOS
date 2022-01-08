//
//  Item.swift
//  FoodRater
//
//  Created by Borna Ungar on 21.12.2021..
//

import Foundation
import UIKit
import RealmSwift

class Item: Object {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var name: String
    @Persisted var rating: Int
    @Persisted var imagePath: Data
    @Persisted var comment: String
    @Persisted var createdAt: Date
}
