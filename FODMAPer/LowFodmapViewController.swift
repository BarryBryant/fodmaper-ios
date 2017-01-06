//
//  LowFodmapViewController.swift
//  FODMAPer
//
//  Created by Richard Bryant on 1/2/17.
//  Copyright © 2017 Joopkins. All rights reserved.
//

import UIKit

class LowFodmapViewController: UIViewController {
    
    @IBOutlet weak var fruitTab: UITabBarItem!
    @IBOutlet weak var vegiTab: UITabBarItem!
    @IBOutlet weak var animalTab: UITabBarItem!
    @IBOutlet weak var grainTab: UITabBarItem!
    @IBOutlet weak var otherTab: UITabBarItem!
    
    @IBOutlet var barItems: [UITabBarItem]!
    
    override func viewDidLoad() {
        initBarItems()
    }
    
    fileprivate func initBarItems() {
        for barItem in barItems {
            let size = CGSize(width: 30, height: 30)
            if let barImage = barItem.image {
                let newImage = Helpers.resizeImage(image: barImage, targetSize: size)
                barItem.image = newImage
                barItem.selectedImage = newImage
            }
        }
    }
}
