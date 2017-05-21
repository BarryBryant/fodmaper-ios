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
    @IBOutlet weak var foodTable: UITableView!
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
        foodField.inputAccessoryView = UIView()
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
        foodTable.reloadData()
        let indexPath = IndexPath(row: foods.count - 1, section: 0)
        foodTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    private func updateSymptomButtons(for severity: SymptomSeverity) {
        mildButton.alpha = severity == .mild ? 1.0: 0.5
        moderateButton.alpha = severity == .moderate ? 1.0: 0.5
        severeButton.alpha = severity == .severe ? 1.0: 0.5
    }
}

extension DiaryEntryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = foodTable.cellForRow(at: indexPath) as? FoodEntryCell
        cell?.setSelected()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = foodTable.cellForRow(at: indexPath) as? FoodEntryCell
        cell?.setDeselected()
    }
    
}

extension DiaryEntryViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = foodTable.dequeueReusableCell(withIdentifier: "FoodEntryCell") as! FoodEntryCell
        cell.foodLabel?.text = foods[indexPath.item]
        cell.delegate = self
        if cell.isSelected {
            cell.setSelected()
        } else {
            cell.setDeselected()
        }
        return cell
    }

}

extension DiaryEntryViewController: FoodEntryCellDelegate {

    func deleteSelectedCell() {
        guard let cellIndex = foodTable.indexPathForSelectedRow?.item else { return }
        foods.remove(at: cellIndex)
        foodTable.reloadData()
    }
    
}

extension DiaryEntryViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == foodField {
            textField.resignFirstResponder()
            self.didTapAdd(textField)
            return true
        }
        return true
    }

}
