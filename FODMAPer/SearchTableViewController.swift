//
//  SearchTableViewController.swift
//  FODMAPer
//
//  Created by Barry Bryant on 1/10/17.
//  Copyright © 2017 Joopkins. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class SearchTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet var foodTable: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var tableViewModel = [Food]()
    var baseViewModel = [Food]()
    var foodRepository = FoodRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FoodCell.registerNib(in: foodTable)
        
        foodTable.dataSource = self
        foodTable.delegate = self
        
        if let searchBar = self.searchBar {
            searchBar.delegate = self
        }
        setData()
    }
    
    func setData() {
        tableViewModel = foodRepository.getAllFoods()
        baseViewModel = foodRepository.getAllFoods()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FoodCell.dequeue(in: tableView, for: indexPath)
        cell.configure(with: tableViewModel[indexPath.row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewModel.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.characters.count > 0 else {
            tableViewModel = baseViewModel
            foodTable.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .fade)
            return
        }
        
        tableViewModel = baseViewModel.filter {
            $0.name.contains(searchText)
        }
        foodTable.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .fade)
    }
    
}
