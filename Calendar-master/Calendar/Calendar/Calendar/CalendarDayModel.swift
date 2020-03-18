//
//  CalendarDayModel.swift
//  Calendar
//
//  Created by  lifirewolf on 16/3/5.
//  Copyright © 2016年 lifirewolf. All rights reserved.
//

import Foundation

enum CellDayType  {
    case Empty   // 不显示
    case Past    // 过去的日期
    case Futur   // 将来的日期
    case Week    // 周末
    case Click    // 被点击的日期
    case LastWhole
    case LastComponent
    case NextWhole
    case NextComponent
    case WhatEver
}

class CalendarDayModel : NSObject {
    
    var style: CellDayType!
    var day: Int!
    var month: Int!
    var year: Int!
    var week: Int!
    
    var Chinese_calendar: String!
    var holiday: String!
    
    static func calendarDayWithYear(year: Int, month: Int, day: Int) -> CalendarDayModel {
        
        let calendarDay = CalendarDayModel()
        
        calendarDay.year = year     // 年
        calendarDay.month = month   // 月
        calendarDay.day = day       // 日
        
        return calendarDay
    }
    
    // 返回当前天的NSDate对象
    var date: NSDate {
        get {
            let comp = NSDateComponents()
            comp.year = year
            comp.month = month
            comp.day = day
            
            return NSCalendar.currentCalendar().dateFromComponents(comp)!
        }
    }
    
    // 返回当前天的NSString对象
    func toString() -> String {
        
        return date.toString()
    }

    // 返回星期
    func getWeek() -> String {
        return date.compareIfTodayWithDate()
    }

    // 判断是不是同一天
    func isEqualTo(day: CalendarDayModel) -> Bool {
        return year == day.year && month == day.month && day == day.day
    }
    
}
