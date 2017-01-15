//
//  File.swift
//  FODMAPer
//
//  Created by Barry Bryant on 1/11/17.
//  Copyright © 2017 Joopkins. All rights reserved.
//

import Foundation

typealias LowFodmapStateChange = (oldState: LowFodmapWorkflow.State, newState: LowFodmapWorkflow.State)

protocol LowFodmapStateObserver: class {
    func onStateChange(_ stateChange: LowFodmapStateChange)
}

final class LowFodmapWorkflow {

    enum Action {
        case tabSelected(Int)
    }
    
    struct State {
        var currentTab: Int
        var food: [Food]
    }
    
    var foodRepository: FoodRepository
    
    weak var observer: LowFodmapStateObserver? = nil
    
    fileprivate(set) var state: State {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.observer?.onStateChange((oldValue, strongSelf.state))
            }
        }
    }
    
    
    init(foodRepository: FoodRepository) {
        self.foodRepository = FoodRepository()
        self.state = State(currentTab: 0, food: foodRepository.getFruits())
    }
    
}

extension LowFodmapWorkflow {

    func dispatchAction(action: Action) {
        switch action {
        case .tabSelected(let tab):
            state = tabSelected(tab: tab)
        }
    }
    
    func tabSelected(tab: Int) -> State {
        var newState = state
        newState.currentTab = tab
        switch tab {
        case 0:
            newState.food = foodRepository.getFruits()
        case 1:
            newState.food = foodRepository.getVegitables()
        case 2:
            newState.food = foodRepository.getAnimalProducts()
        case 3:
            newState.food = foodRepository.getGrains()
        case 4:
            newState.food = foodRepository.getSeasonings()
        default:
            return newState
        }
        return newState
    }
    
}
