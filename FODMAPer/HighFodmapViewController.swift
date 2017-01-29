//
//  HighFodmapViewController.swift
//  FODMAPer
//
//  Created by Barry Bryant on 1/10/17.
//  Copyright © 2017 Joopkins. All rights reserved.
//

import Foundation
import UIKit

final class HighFodmapViewController: SearchTableViewController {
    
    override func setData() {
        tableViewModel = foodRepository.getFodmaps()
        baseViewModel = foodRepository.getFodmaps()
        foodTable.reloadData()
    }
    
}
