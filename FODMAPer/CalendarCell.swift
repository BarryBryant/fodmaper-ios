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
    
    public private(set) var emptyEntry = true
    
    func configure(with state: CellState, entry: DiaryEntry?) {
        dateLabel.text = state.text
        
        emptyEntry = entry == nil
        viewDecoration.backgroundColor = colorForEntry(for: entry)
        didDeselect(state: state)
    }
    
    func didSelect() {
        dateLabel.textColor = UIColor.white
        viewDecoration.isHidden = false
        viewDecoration.alpha = 0.5
    }
    
    func didDeselect(state: CellState) {
        if state.dateBelongsTo == .thisMonth {
            dateLabel.textColor = emptyEntry ? UIColor.black : UIColor.white
        } else {
            dateLabel.textColor = UIColor.gray
        }
        
        viewDecoration.isHidden = emptyEntry
        viewDecoration.alpha = 1.0
    }
    
    private func colorForEntry(for entry: DiaryEntry?) -> UIColor {
        guard let entry = entry
        else {
            return UIColor.fodmaperPurple()
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
