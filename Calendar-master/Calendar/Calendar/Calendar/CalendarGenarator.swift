//
//  CalendarGenarator.swift
//  Calendar
//
//  Created by  lifirewolf on 16/3/5.
//  Copyright © 2016年 lifirewolf. All rights reserved.
//

import UIKit

struct CalendarStyle {
    static let week = 1
    static let lunar = 2
    static let holiday = 4
    static let lunarHoliday = 8
    static let pastAndFutur = 16
    static let region = 32
}

class CalendarGenarator: NSObject {

    var trimMonth = true
    
    private var calWeek = false
    private var calLunar = false
    private var calHoliday = false
    private var calLunarHoliday = false
    private var calPastAndFutur = false
    private var calRegion = false
    
    var style: Int {
        didSet {
            if style & CalendarStyle.week != 0 {
                calWeek = true
            }
            
            if style & CalendarStyle.lunar != 0 {
                calLunar = true
                if style & CalendarStyle.lunarHoliday != 0 {
                    calLunarHoliday = true
                }
            }

            if style & CalendarStyle.holiday != 0 {
                calHoliday = true
            }
            
            if style & CalendarStyle.pastAndFutur != 0 {
                calPastAndFutur = true
            }
            
            if style & CalendarStyle.region != 0 {
                calRegion = true
            }
        }
    }
    
    override init() {
        style = 0
    }
    
    var fromDate: CalendarDate?
    var toDate: CalendarDate?
    
    func genarateCalendarDate(fromDate: NSDate?, daysCount count: Int) -> [[CalendarDate]] {
        let date = fromDate ?? NSDate()
        
        self.fromDate = CalendarDate.genInst(date)
        toDate = CalendarDate.genInst(date.dayInTheFollowingDay(count))
        
        let fromYear = self.fromDate!.year
        let fromMonth = self.fromDate!.month
        
        let toYear = toDate!.year
        let toMonth = toDate!.month
        
        let months = (toYear - fromYear) * 12 + (toMonth - fromMonth)
        
        var calendarMonth = [[CalendarDate]]()
        
        let end = months + 1
        for i in 0 ..< end {
            
            let month = date.dayInTheFollowingMonth(i)
            
            let calendarDays = genarateCalendarDate(month)
            
            calendarMonth.append(calendarDays)
        }
        
        return calendarMonth
    }
    
    func genarateCalendarDate(date: NSDate) -> [CalendarDate] {
        self.fromDate = nil
        self.toDate = nil
        
        var dates = [CalendarDate]()
        
        self.calculateDaysInLastMonth(date, array: &dates)
        self.calculateDaysInCurrentMonth(date, array: &dates)
        
        self.calculateDaysInNextMonth(date, array: &dates)
        
        return dates
    }
    
    /**
    计算上月份的天数
    
    - parameter date: 当前月份的某一天
    - parameter array: 结果存储数组
    */
    func calculateDaysInLastMonth(date: NSDate, inout array: [CalendarDate]) {
        
        let weeklyOrdinality = date.firstDayOfCurrentMonth().weeklyOrdinality()
        let dayInThePreviousMonth = date.dayInThePreviousMonth()
        
        let daysCount = dayInThePreviousMonth.numberOfDaysInCurrentMonth()
        let partialDaysCount = weeklyOrdinality - 1
        
        let components = dayInThePreviousMonth.genYMDComponents()
        
        let start = daysCount - partialDaysCount + 1
        let end = daysCount + 1
        
        for i in start ..< end {
            let calendarDate = CalendarDate(year: components.year, month: components.month, day: i)
            
            calendarDate.monthStatus = MonthStatus.Last
            
            if !trimMonth {
                handleCalendarDate(calendarDate)
            }
            
            array.append(calendarDate)
        }
    }
    
    /**
    计算下月份的天数
    
    - parameter date: 当前月份的某一天
    - parameter array: 结果存储数组
    */
    func calculateDaysInNextMonth(date: NSDate, inout array: [CalendarDate]) {
        
        let weeklyOrdinality = date.lastDayOfCurrentMonth().weeklyOrdinality()
        if weeklyOrdinality != 7 {
            
            let partialDaysCount = 7 - weeklyOrdinality
            let components = date.dayInTheFollowingMonth().genYMDComponents()
            
            let end = partialDaysCount + 1
            for i in 1 ..< end {
                
                let calendarDate = CalendarDate(year: components.year, month: components.month, day: i)
                
                calendarDate.monthStatus = MonthStatus.Next
                
                if !trimMonth {
                    handleCalendarDate(calendarDate)
                }
                
                array.append(calendarDate)
            }
        }
    }
    
    /**
    计算当月的天数
    
    - parameter date: 当前月份的某一天
    - parameter array: 结果存储数组
    */
    func calculateDaysInCurrentMonth(date: NSDate, inout array: [CalendarDate]) {
        
        let daysCount = date.numberOfDaysInCurrentMonth()
        let components = date.genYMDComponents()
        
        let end = daysCount + 1
        for i in 1 ..< end {
            
            let calendarDate = CalendarDate(year: components.year, month: components.month, day: i)
            
            calendarDate.monthStatus = MonthStatus.Current
            
            handleCalendarDate(calendarDate)
            
            array.append(calendarDate)
        }
    }
    
    var extraProcess: ((date: CalendarDate) -> Void)?
    
    private func handleCalendarDate(date: CalendarDate) {
        
        if calWeek {
            calculateWeek(date)
        }
        
        if calLunar {
            calculateLunar(date)
        }
        
        if calHoliday {
            calculateHoliday(date)
        }
        
        if calLunarHoliday {
            calculateLunarHoliday(date)
        }
        
        if calPastAndFutur {
            calculatePastAndFutur(date)
        }
        
        if calRegion {
            calculateRegion(date)
        }
        
        if let process = extraProcess {
            process(date: date)
        }
    }
    
    func calculateWeek(date: CalendarDate) {
        date.week = date.date.getWeekIntValueWithDate()
    }
    
    func calculateLunar(date: CalendarDate) {
        date.lunarCalendar = lunarForSolarYear(date.year, month: date.month, day: date.day)
    }
    
    func lunarForSolarYear(year: Int, month: Int, day: Int) -> String {
        
        var wCurYear = year
        var wCurMonth = month
        var wCurDay = day
        
        // 农历日期名
        let cDayName: [String?] = [
            "*", "初一", "初二", "初三", "初四", "初五", "初六", "初七", "初八", "初九", "初十",
            "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十",
            "廿一", "廿二", "廿三", "廿四", "廿五", "廿六", "廿七", "廿八", "廿九", "三十"
        ]
        
        // 农历月份名
        let cMonName: [String] = ["*", "正", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "腊"]
        
        // 公历每月前面的天数
        let wMonthAdd = [0,31,59,90,120,151,181,212,243,273,304,334]
        
        // 农历数据
        let wNongliData = [
            2635,333387,1701,1748,267701,694,2391,133423,1175,396438
            ,3402,3749,331177,1453,694,201326,2350,465197,3221,3402
            ,400202,2901,1386,267611,605,2349,137515,2709,464533,1738
            ,2901,330421,1242,2651,199255,1323,529706,3733,1706,398762
            ,2741,1206,267438,2647,1318,204070,3477,461653,1386,2413
            ,330077,1197,2637,268877,3365,531109,2900,2922,398042,2395
            ,1179,267415,2635,661067,1701,1748,398772,2742,2391,330031
            ,1175,1611,200010,3749,527717,1452,2742,332397,2350,3222
            ,268949,3402,3493,133973,1386,464219,605,2349,334123,2709
            ,2890,267946,2773,592565,1210,2651,395863,1323,2707,265877
        ]
        
        var nTheDate = 0, nIsEnd = 0, m = 0, k = 0, n = 0, nBit = 0
        
        nTheDate = (wCurYear - 1921) * 365 + (wCurYear - 1921) / 4 + wCurDay + wMonthAdd[wCurMonth - 1] - 38
        
        if wCurYear % 4 == 0 && wCurMonth > 2 {
            nTheDate = nTheDate + 1
        }
        
        // 计算农历天干、地支、月、日
        nIsEnd = 0
        m = 0
        while nIsEnd != 1 {
            if wNongliData[m] < 4095 {
                k = 11
            } else {
                k = 12
            }
            n = k
            while n >= 0 {
                // 获取wNongliData(m)的第n个二进制位的值
                nBit = wNongliData[m]
                for var i: Int = 1; i < n+1; i++ {
                    nBit = nBit/2
                }
                
                nBit = nBit % 2
                
                if nTheDate <= (29 + nBit) {
                    nIsEnd = 1
                    break
                }
                
                nTheDate = nTheDate - 29 - nBit
                n = n - 1
            }
            if nIsEnd != 0 {
                break
            }
            m = m + 1
        }
        
        wCurYear = 1921 + m
        wCurMonth = k - n + 1
        wCurDay = nTheDate
        if k == 12 {
            if wCurMonth == wNongliData[m] / 65536 + 1 {
                wCurMonth = 1 - wCurMonth
            } else if wCurMonth > wNongliData[m] / 65536 + 1 {
                wCurMonth = wCurMonth - 1
            }
        }
        
        // 生成农历月
        let szNongliMonth: String
        
        if wCurMonth < 1 {
            szNongliMonth = "闰" + cMonName[-1 * wCurMonth]
        } else {
            szNongliMonth = cMonName[wCurMonth]
        }
        
        // 生成农历日
        let szNongliDay = cDayName[wCurDay]
        
        // 合并
        let lunarDate = "\(szNongliMonth)-\(szNongliDay)"
        
        return lunarDate
    }
    
    func calculateHoliday(date: CalendarDate) {
        if date.month == 1 && date.day == 1 {
            date.holiday = "元旦"
            
        } else if date.month == 2 && date.day == 14 {// 2.14情人节
            date.holiday = "情人节"
            
        } else if date.month == 3 && date.day == 8 {// 3.8妇女节
            date.holiday = "妇女节"
            
        } else if date.month == 5 && date.day == 1 {// 5.1劳动节
            date.holiday = "劳动节"
            
        } else if date.month == 6 && date.day == 1 {// 6.1儿童节
            date.holiday = "儿童节"
            
        } else if date.month == 8 && date.day == 1 {// 8.1建军节
            date.holiday = "建军节"
            
        } else if date.month == 9 && date.day == 10 {// 9.10教师节
            date.holiday = "教师节"
            
        } else if date.month == 10 && date.day == 1 {// 10.1国庆节
            date.holiday = "国庆节"
            
        } else if date.month == 11 && date.day == 1 {// 11.1植树节
            date.holiday = "植树节"
            
        } else if date.month == 11 && date.day == 11 {// 11.11光棍节
            date.holiday = "光棍节"
        }
    }
    
    func calculateLunarHoliday(date: CalendarDate) {
        guard let lunarCalendar = date.lunarCalendar else {
            return
        }
        
        let lunarCalendarComponents = lunarCalendar.componentsSeparatedByString("-")
        
        if lunarCalendarComponents[0] == "正" && lunarCalendarComponents[1] == "初一" {// 正月初一：春节
            date.lunarHoliday = "春节"
    
        } else if lunarCalendarComponents[0] == "正" && lunarCalendarComponents[1] == "十五" {// 正月十五：元宵节
            date.lunarHoliday = "元宵"
            
        } else if lunarCalendarComponents[0] == "二" && lunarCalendarComponents[1] == "初二" {// 二月初二：春龙节(龙抬头)
            date.lunarHoliday = "龙抬头"
            
        } else if lunarCalendarComponents[0] == "五" && lunarCalendarComponents[1] == "初五" {// 五月初五：端午节
            date.lunarHoliday = "端午"
            
        } else if lunarCalendarComponents[0] == "七" && lunarCalendarComponents[1] == "初七" {// 七月初七：七夕情人节
            date.lunarHoliday = "七夕"
            
        } else if lunarCalendarComponents[0] == "八" && lunarCalendarComponents[1] == "十五" {// 八月十五：中秋节
            date.lunarHoliday = "中秋"
            
        } else if lunarCalendarComponents[0] == "九" && lunarCalendarComponents[1] == "初九" {// 九月初九：重阳节、中国老年节（义务助老活动日）
            date.lunarHoliday = "重阳"
            
        } else if lunarCalendarComponents[0] == "腊" && lunarCalendarComponents[1] == "初八" {// 腊月初八：腊八节
            date.lunarHoliday = "腊八"
            
        } else if lunarCalendarComponents[0] == "腊" && lunarCalendarComponents[1] == "二十四" {// 腊月二十四 小年
            date.lunarHoliday = "小年"
            
        } else if lunarCalendarComponents[0] == "腊" && lunarCalendarComponents[1] == "三十" {// 腊月三十（小月二十九）：除夕
            date.lunarHoliday = "除夕"
        }
    }
    
    func calculatePastAndFutur(date: CalendarDate) {
        
        let today = NSDate().genYMDComponents()
        
        if today.year > date.year {
            date.dateStatus = .Past
            
        } else if today.year == date.year && today.month > date.month {
            date.dateStatus = .Past
            
        } else if today.year == date.year && today.month == date.month && today.day > date.day {
            date.dateStatus = .Past
            
        } else if today.year == date.year && today.month == date.month && today.day == date.day {
            date.dateStatus = .Today
            
        } else {
            date.dateStatus = .Futur
        }
    }
    
    func calculateRegion(date: CalendarDate) {
        
        guard let fd = fromDate, let td = toDate else {
            return
        }
        
        if date.date.timeIntervalSinceDate(fd.date) >= 0 {
            if date.date.timeIntervalSinceDate(fd.date) <= 0 {
                date.timeRegion = TimeRegion.Inside
            } else {
                date.timeRegion = TimeRegion.Greater
            }
        } else {
            date.timeRegion = TimeRegion.Less
        }
    }
}
