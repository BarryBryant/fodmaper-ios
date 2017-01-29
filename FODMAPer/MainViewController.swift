//
//  MainViewController.swift
//  FODMAPer
//
//  Created by Barry Bryant on 1/27/17.
//  Copyright © 2017 Joopkins. All rights reserved.
//

import Foundation
import UIKit

final class MainViewController: UIViewController {
    
    @IBOutlet var mainViewStacks: [UIStackView]!
    
    override func viewDidLoad() {
        for stack in mainViewStacks {
            stack.isUserInteractionEnabled = false
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.setNeedsDisplay()
    }
}
