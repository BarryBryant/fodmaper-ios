//
//  CalendarViewController.swift
//  FODMAPer
//
//  Created by Barry Bryant on 4/30/17.
//  Copyright © 2017 Joopkins. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarViewController: UIViewController {
    
    @IBOutlet weak var calendar: JTAppleCalendarView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCalendar()
    }
    
    func setUpCalendar() {
        calendar.minimumLineSpacing = 0
        calendar.minimumInteritemSpacing = 0
        let currentDate = Date()
        
        configureCalendarLabels(with: currentDate)
        
        calendar.scrollToDate(currentDate,
                              triggerScrollToDateDelegate: true,
                              animateScroll: false,
                              preferredScrollPosition: nil,
                              extraAddedOffset: 0,
                              completionHandler: nil)
        
        calendar.selectDates(from: currentDate, to: currentDate)
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
        cell.configure(with: cellState)
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard let cell = cell as? CalendarCell else { return }
        cell.viewDecoration.isHidden = false
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard let cell = cell as? CalendarCell else { return }
        cell.viewDecoration.isHidden = true
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





