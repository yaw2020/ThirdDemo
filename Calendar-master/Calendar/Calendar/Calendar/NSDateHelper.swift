//
//  NSDateHelper.swift
//  Calendar
//
//  Created by  lifirewolf on 16/3/5.
//  Copyright © 2016年 lifirewolf. All rights reserved.
//

import Foundation

extension NSDate {
    
    // 计算这个月有多少天
    func numberOfDaysInCurrentMonth() -> Int {
    
        // 频繁调用 NSCalendar.currentCalendar() 可能存在性能问题
        
        return NSCalendar.currentCalendar().rangeOfUnit(NSCalendarUnit.Day, inUnit: NSCalendarUnit.Month, forDate: self).length
    }
    
    func firstDayOfCurrentMonth() -> NSDate {
        
        var startDate: NSDate? = nil

        NSCalendar.currentCalendar().rangeOfUnit(NSCalendarUnit.Month, startDate: &startDate, interval: nil, forDate: self)
        
        return startDate!
    }
    
    func weeklyOrdinality() -> Int {
        
        let ordinal = NSCalendar.currentCalendar().ordinalityOfUnit(NSCalendarUnit.NSDayCalendarUnit, inUnit: NSCalendarUnit.NSWeekCalendarUnit, forDate: self)
        return ordinal
    }
    
    // 获取这个月有多少周
    func numberOfWeeksInCurrentMonth() -> Int {
        
        let weekday = self.firstDayOfCurrentMonth().weeklyOrdinality()
        var days = self.numberOfDaysInCurrentMonth()
        var weeks = 0
        
        if weekday > 1 {
            weeks += 1
            days -= (7 - weekday + 1)
        }
        
        weeks += days / 7
        weeks += (days % 7 > 0) ? 1 : 0
        
        return weeks
    }
    
    func lastDayOfCurrentMonth() -> NSDate {
        
        let calendarUnit: NSCalendarUnit = [NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day]
        
        let dateComponents = NSCalendar.currentCalendar().components(calendarUnit, fromDate: self)
        
        dateComponents.day = self.numberOfDaysInCurrentMonth()
        
        return NSCalendar.currentCalendar().dateFromComponents(dateComponents)!
    }

    // last month
    func dayInThePreviousMonth() -> NSDate {
        let dateComponents = NSDateComponents()
        dateComponents.month = -1
        
        return NSCalendar.currentCalendar().dateByAddingComponents(dateComponents, toDate: self, options: NSCalendarOptions())!
    }
    
    func dayInThePreviousMonth(month: Int) -> NSDate {
        let dateComponents = NSDateComponents()
        dateComponents.month = -month
        
        return NSCalendar.currentCalendar().dateByAddingComponents(dateComponents, toDate: self, options: NSCalendarOptions())!
    }
    
    // next month
    func dayInTheFollowingMonth() -> NSDate {
        let dateComponents = NSDateComponents()
        dateComponents.month = 1
        
        return NSCalendar.currentCalendar().dateByAddingComponents(dateComponents, toDate: self, options: NSCalendarOptions())!
    }
    
    func dayInTheFollowingMonth(month: Int) -> NSDate {
        let dateComponents = NSDateComponents()
        dateComponents.month = month
        
        return NSCalendar.currentCalendar().dateByAddingComponents(dateComponents, toDate: self, options: NSCalendarOptions())!
    }

    func dayInTheFollowingDay(day: Int) -> NSDate {
        let dateComponents = NSDateComponents()
        dateComponents.day = day
        
        return NSCalendar.currentCalendar().dateByAddingComponents(dateComponents, toDate: self, options: NSCalendarOptions())!
    }
    
    func genYMDComponents() -> NSDateComponents {
        
        let calendarUnit: NSCalendarUnit = [NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Weekday]
        
        let dateComponents = NSCalendar.currentCalendar().components(calendarUnit, fromDate: self)
        
        return dateComponents
    }
    
    //-----------------------------------------
    
    static func dateFromString(dateString: String, dateFormat: String = "yyyy-MM-dd") -> NSDate? {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = dateFormat
        
        return dateFormatter.dateFromString(dateString)
    }
    
    func toString(dateFormat: String = "yyyy-MM-dd") -> String {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = dateFormat
        
        return dateFormatter.stringFromDate(self)
    }
    
    func getDayNumbertoDay(today: NSDate) -> Int {
        
        var calendar: NSCalendar
        
        if #available(iOS 8.0, *) {
            calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
        } else {
            calendar = NSCalendar.init(calendarIdentifier: NSGregorianCalendar)!
        }
        
        let components = calendar.components(NSCalendarUnit.Day, fromDate: today, toDate: self, options: NSCalendarOptions())
        
        return components.day
    }
    
    // 周日是“1”，周一是“2”...
    func getWeekIntValueWithDate() -> Int {
        
        var calendar: NSCalendar
        
        if #available(iOS 8.0, *) {
            calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
        } else {
            calendar = NSCalendar.init(calendarIdentifier: NSGregorianCalendar)!
        }
        
        let comps = calendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Weekday], fromDate: self)
        
        return comps.weekday
    }
    
    // 判断日期是今天,明天,后天,周几
    func compareIfTodayWithDate() -> String {
        let today = NSDate()
        
        var calendar: NSCalendar
        
        if #available(iOS 8.0, *) {
            calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
        } else {
            calendar = NSCalendar.init(calendarIdentifier: NSGregorianCalendar)!
        }
        
        let compsToday = calendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Weekday], fromDate: today)
        
        let comps_other = calendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Weekday], fromDate: self)
        
        // 获取星期对应的数字
        let weekIntValue = getWeekIntValueWithDate()
        
        if (compsToday.year == comps_other.year &&
            compsToday.month == comps_other.month &&
            compsToday.day == comps_other.day) {
                
                return "今天"
                
        } else if (compsToday.year == comps_other.year &&
            compsToday.month == comps_other.month &&
            (compsToday.day - comps_other.day) == -1) {
                
                return "明天"

        } else if (compsToday.year == comps_other.year &&
            compsToday.month == comps_other.month &&
            (compsToday.day - comps_other.day) == -2) {
                
                return "后天"
                
        } else {
            return NSDate.getWeekStringFromInteger(weekIntValue)
        }
    }
    
    static func getWeekStringFromInteger(week: Int) -> String {
        
        var strWeek: String
        
        switch (week) {
        case 1:
            strWeek = "周日"
        case 2:
            strWeek = "周一"
        case 3:
            strWeek = "周二"
        case 4:
            strWeek = "周三"
        case 5:
            strWeek = "周四"
        case 6:
            strWeek = "周五"
        case 7:
            strWeek = "周六"
        default:
            return "default"
        }
        return strWeek
    }
}
