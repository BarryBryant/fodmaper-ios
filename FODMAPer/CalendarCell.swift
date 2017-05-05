//
//  CalendarCell.swift
//  FODMAPer
//
//  Created by Barry Bryant on 4/30/17.
//  Copyright © 2017 Joopkins. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarCell: JTAppleCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var viewDecoration: UIView!
    
    func configure(with state: CellState) {
        dateLabel.text = state.text
        
        if state.dateBelongsTo == .thisMonth {
            dateLabel.textColor = UIColor.black
        } else {
            dateLabel.textColor = UIColor.gray
        }
        
        if state.isSelected {
            viewDecoration.isHidden = false
        } else {
            viewDecoration.isHidden = true
        }
    }
    
}
