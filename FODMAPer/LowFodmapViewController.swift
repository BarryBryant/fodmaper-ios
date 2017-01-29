//
//  LowFodmapViewController.swift
//  FODMAPer
//
//  Created by Richard Bryant on 1/2/17.
//  Copyright © 2017 Joopkins. All rights reserved.
//

import UIKit
import QuartzCore

final class LowFodmapViewController:
        FadeInTitleBarViewController, UITabBarDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var fruitTab: UITabBarItem!
    @IBOutlet weak var vegiTab: UITabBarItem!
    @IBOutlet weak var animalTab: UITabBarItem!
    @IBOutlet weak var grainTab: UITabBarItem!
    @IBOutlet weak var otherTab: UITabBarItem!
    @IBOutlet weak var foodGroupTabBar: UITabBar!
    @IBOutlet var barItems: [UITabBarItem]!
    @IBOutlet var foodTable: UITableView!

    var foodRepo = FoodRepository()
    var tabForRowDictionary: [Int: IndexPath] = [:]
    var currentTab = 0
    var model = FoodRepository().getFruits()

    override func viewDidLoad() {
        super.viewDidLoad()
        initBarItems()

        self.navigationController?.navigationBar.isHidden = false

        foodGroupTabBar.delegate = self
        foodGroupTabBar.selectedItem = fruitTab

        FoodCell.registerNib(in: foodTable)

        foodTable.dataSource = self
        foodTable.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initIndexPaths()
    }
    
    fileprivate func initBarItems() {
        let size = CGSize(width: 30, height: 30)
        fruitTab.image = ImageHelpers.resizeImage(image: UIImage(named: "fruit")!, targetSize: size)
        vegiTab.image = ImageHelpers.resizeImage(image: UIImage(named: "vegitable")!, targetSize: size)
        animalTab.image = ImageHelpers.resizeImage(image: UIImage(named: "animal")!, targetSize: size)
        grainTab.image = ImageHelpers.resizeImage(image: UIImage(named: "wheat")!, targetSize: size)
        otherTab.image = ImageHelpers.resizeImage(image: UIImage(named: "seasoning")!, targetSize: size)
    }
    
    fileprivate func initIndexPaths() {
        tabForRowDictionary[0] = foodTable.indexPathsForVisibleRows?[0]
        tabForRowDictionary[1] = foodTable.indexPathsForVisibleRows?[0]
        tabForRowDictionary[2] = foodTable.indexPathsForVisibleRows?[0]
        tabForRowDictionary[3] = foodTable.indexPathsForVisibleRows?[0]
        tabForRowDictionary[4] = foodTable.indexPathsForVisibleRows?[0]
    }

    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        tabForRowDictionary[currentTab] = foodTable.indexPathsForVisibleRows?[0]
        currentTab = item.tag
        
        switch currentTab {
        case 0:
            model = foodRepo.getFruits()
        case 1:
            model = foodRepo.getVegitables()
        case 2:
            model = foodRepo.getAnimalProducts()
        case 3:
            model = foodRepo.getGrains()
        case 4:
            model = foodRepo.getSeasonings()
        default:
            return
        }
        reloadData()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FoodCell.dequeue(in: tableView, for: indexPath)
        cell.configure(with: model[indexPath.row])
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func reloadData() {
        foodTable.reloadData()
        guard let row = tabForRowDictionary[currentTab] else {
            return
        }
        foodTable.scrollToRow(at: row, at: .top, animated: false)
    }
}
