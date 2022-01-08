//
//  AddItemViewModel.swift
//  FoodRater
//
//  Created by Borna Ungar on 01.01.2022..
//

import Foundation
import RxCocoa
import RxSwift
protocol AddItemViewModel: AnyObject {
    var rating: Int? {get set}
        
    func addItem(name: String, rating: Int, imagePath: Data, comment: String?)
}

class AddItemViewModelImpl: AddItemViewModel {
    
    private let itemRepository: FoodRaterRepository
    
    var rating: Int?
    
    init(itemRepository: FoodRaterRepository) {
        self.itemRepository = itemRepository
    }
    
    func addItem(name: String, rating: Int, imagePath: Data, comment: String? = "") {
        self.itemRepository.addUpdateToList(name: name, rating: rating, imagePath: imagePath, comment: comment)
    }

}
