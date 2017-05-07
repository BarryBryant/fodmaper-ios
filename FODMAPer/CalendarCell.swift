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
    
    var emptyEntry = true
    
    func configure(with state: CellState, entry: DiaryEntry?) {
        dateLabel.text = state.text
        
        if state.dateBelongsTo == .thisMonth {
            dateLabel.textColor = UIColor.black
        } else {
            dateLabel.textColor = UIColor.gray
        }
        
        emptyEntry = entry == nil
        viewDecoration.backgroundColor = colorForEntry(for: entry)
        didDeselect()
    }
    
    func didSelect() {
        viewDecoration.isHidden = false
        viewDecoration.alpha = 1.0
    }
    
    func didDeselect() {
        viewDecoration.isHidden = emptyEntry
        viewDecoration.alpha = 0.5
    }
    
    private func colorForEntry(for entry: DiaryEntry?) -> UIColor {
        guard let entry = entry
        else {
            return UIColor.lightGray
        }
        
        switch entry.severity {
        case .mild:
            return UIColor.fodmaperGreen()
        case .moderate:
            return UIColor.fodmaperOrange()
        case .severe:
            return UIColor.fodmaperRed()
        }
    }
}
