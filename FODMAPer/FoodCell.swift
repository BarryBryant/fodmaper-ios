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
        
        fLabel.alpha = (food.f > 0) ? 1.0 : 0.1
        oLabel.alpha = (food.o != 0) ? 1.0 : 0.1
        dLabel.alpha = (food.d != 0) ? 1.0 : 0.1
        mLabel.alpha = (food.m != 0) ? 1.0 : 0.1
        aLabel.alpha = (food.p != 0) ? 1.0 : 0.1
        pLabel.alpha = (food.p != 0) ? 1.0 : 0.1
    }
    
    fileprivate func getColorForFoodTier(tier: Int) -> UIColor {
        switch tier {
        case 0:
            return UIColor.black
        case 1:
            return UIColor(red:0.95, green:0.73, blue:0.45, alpha:1.0)
        case 2:
            return UIColor(red:1.00, green:0.52, blue:0.65, alpha:1.0)
        default:
            return UIColor.black
        }
    }
}
