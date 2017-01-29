//
//  LowFodmapViewController.swift
//  FODMAPer
//
//  Created by Richard Bryant on 1/2/17.
//  Copyright © 2017 Joopkins. All rights reserved.
//

import UIKit
import QuartzCore

protocol LowFodmapView {
    func reloadData()
}

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

    var workflow: LowFodmapWorkflow!
    var presenter: LowFodmapPresenter!
    var tabForRowDictionary: [Int: IndexPath] = [:]
    var currentTab = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        initBarItems()

        self.navigationController?.navigationBar.isHidden = false

        foodGroupTabBar.delegate = self
        foodGroupTabBar.selectedItem = fruitTab

        FoodCell.registerNib(in: foodTable)

        foodTable.dataSource = self
        foodTable.delegate = self

        self.workflow = LowFodmapWorkflow(foodRepository: FoodRepository())
        self.presenter = LowFodmapPresenter()
        presenter.subscribe(view: self)
        workflow.observer = presenter

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if presenter != nil {
            presenter.unsubscribe()
        }
    }

    fileprivate func initBarItems() {
        let size = CGSize(width: 30, height: 30)
        fruitTab.image = ImageHelpers.resizeImage(image: UIImage(named: "fruit")!, targetSize: size)
        vegiTab.image = ImageHelpers.resizeImage(image: UIImage(named: "vegitable")!, targetSize: size)
        animalTab.image = ImageHelpers.resizeImage(image: UIImage(named: "animal")!, targetSize: size)
        grainTab.image = ImageHelpers.resizeImage(image: UIImage(named: "wheat")!, targetSize: size)
        otherTab.image = ImageHelpers.resizeImage(image: UIImage(named: "seasoning")!, targetSize: size)
    }

    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        tabForRowDictionary[currentTab] = foodTable.indexPathsForVisibleRows?[0]
        currentTab = item.tag
        workflow.dispatchAction(action: .tabSelected(item.tag))
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FoodCell.dequeue(in: tableView, for: indexPath)
        cell.configure(with: workflow.state.food[indexPath.row])
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let workflow = workflow {
            return workflow.state.food.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

extension LowFodmapViewController: LowFodmapView {

    func reloadData() {
        foodTable.reloadData()
    }

}
