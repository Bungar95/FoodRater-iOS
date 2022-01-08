//
//  ItemViewModel.swift
//  FoodRater
//
//  Created by Borna Ungar on 01.01.2022..
//

import Foundation
import RxSwift
import RxCocoa
protocol ItemViewModel: AnyObject {
    var listRelay: BehaviorRelay<[Item]> {get}
    
    var loaderSubject: ReplaySubject<Bool> {get}
    var loadListSubject: ReplaySubject<()> {get}
    
    func initializeViewModelObservables() -> [Disposable]
}

class ItemViewModelImpl: ItemViewModel {
    
    private let itemRepository: FoodRaterRepository

    var listRelay = BehaviorRelay<[Item]>.init(value: [])
        
    var loaderSubject = ReplaySubject<Bool>.create(bufferSize: 1)
    var loadListSubject = ReplaySubject<()>.create(bufferSize: 1)
    
    init(itemRepository: FoodRaterRepository) {
        self.itemRepository = itemRepository
    }
    
    func initializeViewModelObservables() -> [Disposable] {
        var disposables: [Disposable] = []
        disposables.append(initializeListSubject(subject: loadListSubject))
        return disposables
    }
}

private extension ItemViewModelImpl {
    
    func initializeListSubject(subject: ReplaySubject<()>) -> Disposable {
        return subject
            .observe(on: MainScheduler.instance)
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { _ in
                self.loaderSubject.onNext(true)
                let items = self.itemRepository.fetchList()
                self.listRelay.accept(items)
                self.loaderSubject.onNext(false)
            })
    }
}
