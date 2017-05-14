//
//  FoodEntryCellCollectionViewCell.swift
//  FODMAPer
//
//  Created by Barry Bryant on 5/7/17.
//  Copyright © 2017 Joopkins. All rights reserved.
//

import UIKit

protocol FoodEntryCellDelegate {
    
    func deleteSelectedCell()
    
}

class FoodEntryCell: UITableViewCell {
    
    var delegate: FoodEntryCellDelegate?
    
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBAction func didTapDelete(_ sender: Any) {
        delegate?.deleteSelectedCell()
    }
    
    public func setSelected() {
        foodLabel.textColor = UIColor.fodmaperRed()
        deleteButton.isHidden = false
    }
    
    public func setDeselected() {
        foodLabel.textColor = UIColor.black
        deleteButton.isHidden = true
    }

}
