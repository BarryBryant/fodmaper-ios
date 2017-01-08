//
//  FodmapCell.swift
//  FODMAPer
//
//  Created by Barry Bryant on 1/7/17.
//  Copyright © 2017 Joopkins. All rights reserved.
//

import Foundation
import UIKit

final class FoodCell: UITableViewCell {
    
    static let defaultReuseIdentifier = "FoodCell"
    static let defaultNibName = "FoodCell"
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var fLabel: UILabel!
    @IBOutlet var oLabel: UILabel!
    @IBOutlet var dLabel: UILabel!
    @IBOutlet var mLabel: UILabel!
    @IBOutlet var aLabel: UILabel!
    @IBOutlet var pLabel: UILabel!
    
    static func registerNib(in tableView: UITableView) {
        tableView.register(
            UINib(nibName: defaultNibName, bundle: nil),
            forCellReuseIdentifier: defaultReuseIdentifier
        )
    }
    
    static func dequeue(in tableView: UITableView, for indexPath: IndexPath) -> FoodCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: defaultReuseIdentifier,
            for: indexPath
        )
        return cell as! FoodCell
    }
    
    func configure(with food: Food) {
        nameLabel.text = food.name
        
        let tierColor = getColorForFoodTier(tier: food.f)
        fLabel.textColor = (food.f != 0) ? tierColor : UIColor.black
        oLabel.textColor = (food.o != 0) ? tierColor : UIColor.black
        dLabel.textColor = (food.d != 0) ? tierColor : UIColor.black
        mLabel.textColor = (food.m != 0) ? tierColor : UIColor.black
        aLabel.textColor = (food.p != 0) ? tierColor : UIColor.black
        pLabel.textColor = (food.p != 0) ? tierColor : UIColor.black
    }
    
    fileprivate func getColorForFoodTier(tier: Int) -> UIColor {
        switch tier {
        case 0:
            return UIColor.black
        case 1:
            return UIColor.yellow
        case 2:
            return UIColor.red
        default:
            return UIColor.black
        }
    }
}
