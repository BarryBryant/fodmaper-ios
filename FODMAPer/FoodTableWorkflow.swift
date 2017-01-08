//
//  FoodTableWorkflow.swift
//  FODMAPer
//
//  Created by Richard Bryant on 1/8/17.
//  Copyright © 2017 Joopkins. All rights reserved.
//

import Foundation

typealias FoodTableWorkflowStateChange = (oldState: FoodTableWorkflow.State, newState: FoodTableWorkflow.State)

protocol FoodTableWorkflowObserver: class {
    
    func onStateChange(_ change: FoodTableWorkflowStateChange)
    
}

final class FoodTableWorkflow {
    
    enum Action {
        case reloadData(Array<Food>)
    }
    
    struct State {
        var displayedFood: Array<Food>
    }
    
    weak var observer: FoodTableWorkflowObserver? = nil
    
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
    
    init(with foods: Array<Food>) {
        state = State(displayedFood: foods)
    }
    
}

extension FoodTableWorkflow {

    func dispatch(_ action: Action) {
        switch action {
        case .reloadData(let food):
            state = reloadData(with: food)
        }
    }
    
    fileprivate func reloadData(with food: Array<Food>) -> State {
        var newState = state
        newState.displayedFood = food
        return newState
    }
    
}




