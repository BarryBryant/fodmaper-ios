//
//  LowFodmapPresenter.swift
//  FODMAPer
//
//  Created by Barry Bryant on 1/11/17.
//  Copyright © 2017 Joopkins. All rights reserved.
//

import Foundation

final class LowFodmapPresenter {

    var view: LowFodmapView!
    
    func subscribe(view: LowFodmapView) {
        self.view = view
    }
    
    func unsubscribe() {
        self.view = nil
    }
    
}

extension LowFodmapPresenter: LowFodmapStateObserver {
    
    func onStateChange(_ stateChange: LowFodmapStateChange) {
        if stateChange.newState.currentTab != stateChange.oldState.currentTab {
            view.reloadData()
        }
    }
    
}
