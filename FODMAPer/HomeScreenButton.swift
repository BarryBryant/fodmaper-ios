//
//  HomeScreenButton.swift
//  FODMAPer
//
//  Created by Barry Bryant on 1/27/17.
//  Copyright © 2017 Joopkins. All rights reserved.
//

import Foundation
import UIKit

final class HomeScreenButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                self.backgroundColor = UIColor(cgColor: (self.backgroundColor?.cgColor.copy(alpha: 0.8))!)
            } else {
                self.backgroundColor = UIColor(cgColor: (self.backgroundColor?.cgColor.copy(alpha: 1.0))!)
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.backgroundColor = UIColor(cgColor: (self.backgroundColor?.cgColor.copy(alpha: 0.8))!)
            } else {
                self.backgroundColor = UIColor(cgColor: (self.backgroundColor?.cgColor.copy(alpha: 1.0))!)
            }
        }
    }
    
}
