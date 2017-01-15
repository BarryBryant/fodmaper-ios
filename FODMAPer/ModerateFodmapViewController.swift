//
//  ModerateFodmapViewController.swift
//  FODMAPer
//
//  Created by Barry Bryant on 1/10/17.
//  Copyright © 2017 Joopkins. All rights reserved.
//

import Foundation
import UIKit

final class ModerateFodmapViewController: SearchTableViewController {

    override func setData() {
        tableViewModel = foodRepository.getModerates()
        foodTable.reloadData()
    }
    
}
