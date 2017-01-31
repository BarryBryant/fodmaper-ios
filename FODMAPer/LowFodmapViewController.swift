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
    var indexPathForTab: [Tab: IndexPath] = [:]
    enum Tab: Int {
        case fruit = 0
        case vegitable = 1
        case animal = 2
        case grain = 3
        case other = 4
    }
    var currentTab: Tab = .fruit
    var model = FoodRepository().getFruits()

    override func viewDidLoad() {
        super.viewDidLoad()
        initBarItems()

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
        indexPathForTab[.fruit] = foodTable.indexPathsForVisibleRows?[0]
        indexPathForTab[.vegitable] = foodTable.indexPathsForVisibleRows?[0]
        indexPathForTab[.animal] = foodTable.indexPathsForVisibleRows?[0]
        indexPathForTab[.grain] = foodTable.indexPathsForVisibleRows?[0]
        indexPathForTab[.other] = foodTable.indexPathsForVisibleRows?[0]
    }

    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        indexPathForTab[currentTab] = foodTable.indexPathsForVisibleRows?[0]
        guard let currentTab = LowFodmapViewController.Tab(rawValue: item.tag) else {
            print("Bad tab index")
            return
        }
        self.currentTab = currentTab
        
        switch currentTab {
        case .fruit:
            model = foodRepo.getFruits()
        case .vegitable:
            model = foodRepo.getVegitables()
        case .animal:
            model = foodRepo.getAnimalProducts()
        case .grain:
            model = foodRepo.getGrains()
        case .other:
            model = foodRepo.getSeasonings()
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
        guard let row = indexPathForTab[currentTab] else {
            return
        }
        foodTable.scrollToRow(at: row, at: .top, animated: false)
    }
}
