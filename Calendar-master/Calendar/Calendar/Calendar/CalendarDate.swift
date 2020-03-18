//
//  CalendarDate.swift
//  Calendar
//
//  Created by  lifirewolf on 16/3/5.
//  Copyright © 2016年 lifirewolf. All rights reserved.
//

import UIKit

enum DateStatus {
    case Past
    case Today
    case Futur
}

enum MonthStatus {
    case Last
    case Current
    case Next
}

enum TimeRegion {
    case Less
    case Inside
    case Greater
}

class CalendarDate: NSObject {

    var day: Int {
        didSet {
            realDate = nil
        }
    }
    
    var month: Int {
        didSet {
            realDate = nil
        }
    }
    
    var year: Int {
        didSet {
            realDate = nil
        }
    }
    
    var isSelected = false
    
    var week: Int?
    
    var lunarCalendar: String?
    
    var holiday: String?
    
    var lunarHoliday: String?
    
    var dateStatus: DateStatus?
    
    var monthStatus: MonthStatus?
    
    var timeRegion: TimeRegion?
    
    init(year: Int, month: Int, day: Int) {
        self.year = year
        self.month = month
        self.day = day
    }
    
    // 返回当前天的NSDate对象
    private var realDate: NSDate?
    var date: NSDate {
        if realDate == nil {
            let comp = NSDateComponents()
            comp.year = self.year
            comp.month = self.month
            comp.day = self.day
            
            realDate = NSCalendar.currentCalendar().dateFromComponents(comp)!
        }
        return realDate!
    }
    
    // 返回当前天的NSString对象
    func toString() -> String {
        return date.toString()
    }
    
    // 判断是不是同一天
    func isEqualTo(day: CalendarDate) -> Bool {
        return (self.year == day.year) && (self.month == day.month) && (self.day == day.day)
    }
    
    func isWeekday() -> Bool {
        if nil == week {
            week = date.getWeekIntValueWithDate()
        }
        
        if week! == 1 || week! == 7 {
            return true
        }
        
        return false
    }
    
    static func genInst(date: NSDate) -> CalendarDate {
        let comp = date.genYMDComponents()
        return CalendarDate(year: comp.year, month: comp.month, day: comp.day)
    }
}
