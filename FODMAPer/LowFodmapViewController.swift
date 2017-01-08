//
//  LowFodmapViewController.swift
//  FODMAPer
//
//  Created by Richard Bryant on 1/2/17.
//  Copyright © 2017 Joopkins. All rights reserved.
//

import UIKit

class LowFodmapViewController: UIViewController, UITabBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var fruitTab: UITabBarItem!
    @IBOutlet weak var vegiTab: UITabBarItem!
    @IBOutlet weak var animalTab: UITabBarItem!
    @IBOutlet weak var grainTab: UITabBarItem!
    @IBOutlet weak var otherTab: UITabBarItem!
    
    @IBOutlet weak var foodGroupTabBar: UITabBar!
    @IBOutlet var barItems: [UITabBarItem]!
    
    @IBOutlet var foodTable: UITableView!
    
    var foods: Array<Food>!
    
    override func viewDidLoad() {
        initBarItems()
        foodGroupTabBar.delegate = self
        foodGroupTabBar.selectedItem = fruitTab
        let foodRepo = FodmapRepository.init()
        foods = foodRepo.getFruits()
        FoodCell.registerNib(in: foodTable)
        foodTable.dataSource = self
        foodTable.delegate = self
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
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == fruitTab {
            print("sup")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = FoodCell.dequeue(in: tableView, for: indexPath)
        cell.configure(with: self.foods[indexPath.row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
        
    
}
