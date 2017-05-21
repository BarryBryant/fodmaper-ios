//
//  CalendarViewController.swift
//  FODMAPer
//
//  Created by Barry Bryant on 4/30/17.
//  Copyright © 2017 Joopkins. All rights reserved.
//

import UIKit
import JTAppleCalendar
import Realm
import RealmSwift

class CalendarViewController: UIViewController {
    
    @IBOutlet weak var calendar: JTAppleCalendarView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var diaryButton: UIButton!
    
    let formatter = DateFormatter()
    var didInitiallyLoad = false
    let repo: DiaryRepository? = DiaryRepository()
    var lastSelectedDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard repo != nil else {
            return //show error
        }
        self.setUpCalendar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        calendar.reloadData()
        
        if lastSelectedDate != nil {
            calendar.selectDates(from: lastSelectedDate!, to: lastSelectedDate!)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.lastSelectedDate = calendar.selectedDates.first!
    }
    
    func setUpCalendar() {
        calendar.minimumLineSpacing = 0
        calendar.minimumInteritemSpacing = 0
        let currentDate = Date()
        
        calendar.scrollToDate(currentDate,
                              triggerScrollToDateDelegate: true,
                              animateScroll: false,
                              preferredScrollPosition: nil,
                              extraAddedOffset: 0, completionHandler: nil)
        
        calendar.selectDates(from: currentDate, to: currentDate)
    }
    
    @IBAction func didTapSelect(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let diaryEntryViewController = storyboard.instantiateViewController(withIdentifier: "DiaryEntry") as? DiaryEntryViewController
        
        let selectedDate = calendar.selectedDates.first!
        
        if let entry = repo?.getDiaryEntryForDate(selectedDate) {
            diaryEntryViewController?.injectEntry(entry: entry)
        } else {
            let entry = DiaryEntry()
            entry.build(for: selectedDate)
            diaryEntryViewController?.injectEntry(entry: entry)
        }
        
        present(diaryEntryViewController!, animated: true, completion: nil)
    }
    
}

extension CalendarViewController {
    
    func configureCalendarLabels(with date: Date) {
        let calendar
            = Calendar.current
        
        let monthNumber = calendar.component(.month, from: date)
        let month = calendar.monthSymbols[monthNumber-1]
        monthLabel.text = month
        
        let year = calendar.component(.year, from: date)
        yearLabel.text = "\(year)"
    }
    
}

extension CalendarViewController: JTAppleCalendarViewDelegate {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        let startDate = formatter.date(from: "2017 01 01")
        let endDate = formatter.date(from: "2027 12 31")
        let parameters = ConfigurationParameters(startDate: startDate!, endDate: endDate!)
        return parameters
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        guard let currentMonthDate = visibleDates.monthDates.first?.date else {
            return
        }
        configureCalendarLabels(with: currentMonthDate)
    }
        
}

extension CalendarViewController: JTAppleCalendarViewDataSource {
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        let entry = repo?.getDiaryEntryForDate(date)
        cell.configure(with: cellState, entry: entry)
        if cellState.isSelected { cell.didSelect() }
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard let cell = cell as? CalendarCell else { return }
        cell.didSelect()
        let title = cell.emptyEntry ? "New Entry" : "Edit Entry"
        diaryButton.setTitle(title, for: .normal)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard let cell = cell as? CalendarCell else { return }
        cell.didDeselect(state: cellState)
    }
    
}







