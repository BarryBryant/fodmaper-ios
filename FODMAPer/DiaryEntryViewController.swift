//
//  DiaryEntryViewController.swift
//  FODMAPer
//
//  Created by Barry Bryant on 5/7/17.
//  Copyright © 2017 Joopkins. All rights reserved.
//

import UIKit

class DiaryEntryViewController: UIViewController {
    
    @IBOutlet weak var mildButton: UIButton!
    @IBOutlet weak var moderateButton: UIButton!
    @IBOutlet weak var severeButton: UIButton!
    @IBOutlet weak var saveEntryButton: UIButton!
    @IBOutlet weak var foodCollection: UICollectionView!
    @IBOutlet weak var foodField: UITextField!
    
    var entry: DiaryEntry!
    var foods: [String] = []
    
    let repo: DiaryRepository? = DiaryRepository()
    var selectedSeverityNumber = 1
    
    public func injectEntry(entry: DiaryEntry) {
        self.entry = entry
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(entry != nil)
        foods.append(contentsOf: entry.foodArray)
        updateSymptomButtons(for: entry.severity)
    }
    
    @IBAction func didTapMild(_ sender: Any) {
        updateSymptomButtons(for: .mild)
        selectedSeverityNumber = 1
        
    }
    
    @IBAction func didTapModerate(_ sender: Any) {
        updateSymptomButtons(for: .moderate)
        selectedSeverityNumber = 2
    }
    
    @IBAction func didTapSevere(_ sender: Any) {
        updateSymptomButtons(for: .severe)
        selectedSeverityNumber = 3
    }
    
    @IBAction func didTapSave(_ sender: Any) {
        let freshEntry = DiaryEntry()
        freshEntry.build(for: entry.date)
        freshEntry.symptomSeverityNumber = selectedSeverityNumber
        freshEntry.setFoods(foods: foods)
        try? repo?.storeDiaryEntry(entry: freshEntry)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapAdd(_ sender: Any) {
        guard let text = foodField.text,
            text.characters.count > 0
        else { return }
        foods.append(text)
        foodField.text = ""
        foodCollection.reloadData()
        foodCollection.setNeedsDisplay()
    }
    
    private func updateSymptomButtons(for severity: SymptomSeverity) {
        mildButton.alpha = severity == .mild ? 1.0: 0.5
        moderateButton.alpha = severity == .moderate ? 1.0: 0.5
        severeButton.alpha = severity == .severe ? 1.0: 0.5
    }
}

extension DiaryEntryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //sup
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        //nm
    }
    
    
}

extension DiaryEntryViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = foodCollection.dequeueReusableCell(withReuseIdentifier: "FoodEntryCell", for: indexPath) as! FoodEntryCell
        cell.foodLabel?.text = foods[indexPath.item]
        return cell
    }

}
