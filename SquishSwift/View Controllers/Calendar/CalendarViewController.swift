//
//  CalendarViewController.swift
//  SquishSwift
//
//  Created by Max Fritzhand on 11/24/19.
//  Copyright © 2019 Max Fritzhand. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarViewController: UIViewController {
    @IBOutlet weak var calendarView: JTACMonthView!
    @IBOutlet weak var tableView: UITableView!
    
    
    // after scheduleGroup is set with new Schedule reloadData to inject
    // MARK: DataSource
    var scheduleGroup : [String: [Schedule]]? {
        didSet {
//            calendarView.reloadData()
            tableView.reloadData()
        }
    }
    
    var schedules: [Schedule] {
        get {
            guard let selectedDate = calendarView.selectedDates.first else {
                return []
            }

            guard let data = scheduleGroup?[self.formatter.string(from: selectedDate)] else {
                return []
            }

            return data.sorted()
        }
    }
    
    // Config
    let scheduleCellIdentifier = "appt"
    
    // Add DateFormatter to be used globally for events and the dataSource dictionary.
    var calendarDataSource: [String:String] = [:]
    var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        return formatter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewNibs()
        calendarView.scrollDirection = .horizontal
        calendarView.scrollingMode = .stopAtEachCalendarFrame
        calendarView.showsHorizontalScrollIndicator = false
        populateDataSource()
    }
    
    func setupViewNibs() {
        
        let myNib2 = UINib(nibName: "ScheduleTableViewCell", bundle: Bundle.main)
        tableView.register(myNib2, forCellReuseIdentifier: scheduleCellIdentifier)
    }
   
    
    // change status text color
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func configureCell(view: JTACDayCell?, cellState: CellState) {
       guard let cell = view as? DateCell  else { return }
       cell.dateLabel.text = cellState.text
       handleCellTextColor(cell: cell, cellState: cellState)
       handleCellSelected(cell: cell, cellState: cellState)
        handleCellEvents(cell: cell, cellState: cellState)
    }
        
    func handleCellTextColor(cell: DateCell, cellState: CellState) {
       if cellState.dateBelongsTo == .thisMonth {
        cell.dateLabel.textColor = UIColor.white
        cell.isHidden = false
       } else {
//          cell.dateLabel.textColor = UIColor.clear
         cell.isHidden = true
       }
    }
    
    func handleCellSelected(cell: DateCell, cellState: CellState) {
        if cellState.isSelected {
            cell.selectedView.layer.cornerRadius =  13
            cell.selectedView.isHidden = false
        } else {
            cell.selectedView.isHidden = true
        }
    }
    // Checks to see if cell has an event with same date 
    func handleCellEvents(cell: DateCell, cellState: CellState) {
        let dateString = formatter.string(from: cellState.date)
        
        if calendarDataSource[dateString] == nil {
            cell.circledDate.isHidden = true
        } else {
            cell.circledDate.isHidden = false
        }
    }
    

    
    func populateDataSource() {
        // You can get the data from a server.
        // Then convert that data into a form that can be used by the calendar.
        calendarDataSource = [
            "07-Nov-2019": "Andrew Hong",
            "15-Nov-2019": "Max Fritzhand",
            "26-Nov-2019": "Derek Bullard",
            "20-Dec-2019": "John Lang",
        ]
        // update the calendar
        calendarView.reloadData()
    }
    

    
//    Delegate Function to prevent selection
//    func calendar(_ calendar: JTAppleCalendarView, shouldSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) -> Bool {
//        return true // Based on a criteria, return true or false
//    }
    


}

extension CalendarViewController: JTACMonthViewDataSource {
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy MM dd"
//        let startDate = formatter.date(from: "2019 11 01")!
        let startDate = formatter.date(from: "01-nov-2019")!
//        let endDate = Date()
//        let endDate = formatter.date(from: "2020 12 31")!
        let endDate = formatter.date(from: "31-dec-2020")!
        return ConfigurationParameters(startDate: startDate, endDate: endDate, generateInDates: .forAllMonths, generateOutDates: .off, hasStrictBoundaries: true)
    }
}

extension CalendarViewController: JTACMonthViewDelegate {
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
            let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
            self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
            return cell
        }
        
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
            configureCell(view: cell, cellState: cellState)
        }
    
    
    
    
        ////////////////////////////////////////////////////////////////////////////////////  FUNCTION FOR TABLE VIEW INJECT
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
            configureCell(view: cell, cellState: cellState)
        // do something here to check date against events in sourceData
        let dateString = formatter.string(from: cellState.date)
        
        
        if calendarDataSource[dateString] != nil {
            let seekerName = calendarDataSource[dateString]
            print (seekerName!)
            var schedules: [Schedule] = []
            schedules.append(Schedule(startDate: dateString, seekerName: seekerName!))
            print(schedules)
            //        If there are multiple events, sort by startTime
            scheduleGroup = schedules.group{_ in formatter.string(from: date)}
        }
    }
    
    
    

    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
            configureCell(view: cell, cellState: cellState)
        }
    
    func calendar(_ calendar: JTACMonthView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTACMonthReusableView {
        let formatter = DateFormatter()  // Declare this outside, to avoid instancing this heavy class multiple times.
        formatter.dateFormat = "MMM"

        let header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: "DateHeader", for: indexPath) as! DateHeader
        header.monthTitle.text = formatter.string(from: range.start)
        formatter.dateFormat = "yyyy"
        header.yearTitle.text = formatter.string(from: range.start)

        // Background Color
        let gradientLayer = CAGradientLayer()
        let colorTop = UIColor(red: 87/255.0, green: 71/255.0, blue: 216/255.0, alpha: 1).cgColor
        let colorBottom = UIColor(red: 173/255.0, green: 41/255.0, blue: 213/255.0, alpha: 1).cgColor
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = header.bounds
        header.layer.insertSublayer(gradientLayer, at: 0)


        return header
    }

    func calendarSizeForMonths(_ calendar: JTACMonthView?) -> MonthSize? {
        return MonthSize(defaultSize: 100)
    }
    
    
    }


// MARK: UITableViewDataSource
extension CalendarViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: scheduleCellIdentifier, for: indexPath) as? ScheduleTableViewCell
        cell!.selectionStyle = .none
        cell!.schedule = schedules[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedules.count
    }
}

// MARK: UITableViewDelegate
extension CalendarViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let schedule = schedules[indexPath.row]
        
        print(schedule)
        print("schedule selected")
    }
}
