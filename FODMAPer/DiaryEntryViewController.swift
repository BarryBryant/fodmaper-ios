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
    
    var entry: DiaryEntry!
    
    let repo: DiaryRepository? = DiaryRepository()
    var selectedSeverityNumber = 1
    
    public func injectEntry(entry: DiaryEntry) {
        self.entry = entry
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(entry != nil)
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
        try? repo?.storeDiaryEntry(entry: freshEntry)
        self.dismiss(animated: true, completion: nil)
    }
    
    private func updateSymptomButtons(for severity: SymptomSeverity) {
        mildButton.alpha = severity == .mild ? 1.0: 0.5
        moderateButton.alpha = severity == .moderate ? 1.0: 0.5
        severeButton.alpha = severity == .severe ? 1.0: 0.5
    }
}
