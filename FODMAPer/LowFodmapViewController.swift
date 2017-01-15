//
//  LowFodmapViewController.swift
//  FODMAPer
//
//  Created by Richard Bryant on 1/2/17.
//  Copyright © 2017 Joopkins. All rights reserved.
//

import UIKit

protocol LowFodmapView {
    func reloadData()
}

final class LowFodmapViewController: UIViewController, UITabBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBarItems()
        
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
        presenter.unsubscribe()
    }
    
    fileprivate func initBarItems() {
        for barItem in barItems {
            let size = CGSize(width: 30, height: 30)
            if let barImage = barItem.image {
                let newImage = ImageHelpers.resizeImage(image: barImage, targetSize: size)
                barItem.image = newImage
                barItem.selectedImage = newImage
            }
        }
    }
    
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
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
        return workflow.state.food.count
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
