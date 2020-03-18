//
//  CalendarManager.swift
//  Calendar
//
//  Created by  lifirewolf on 16/3/5.
//  Copyright © 2016年 lifirewolf. All rights reserved.
//

import UIKit

class CalendarManager: NSObject {
    
    private let maxCacheSize = 100
    private let threshold = 10
    
    var genarator: CalendarGenarator!
    
    private var currentIndex = 0 {
        didSet {
            var forward = false
            var backward = false
            
            if currentIndex - 0 < threshold {
                // add backward
                let date = cache[0][7].date
                
                for i in 1 ..< 11 {
                    let month = date.dayInThePreviousMonth(i)
                    let dates = genarator.genarateCalendarDate(month)
                    cache.insert(dates, atIndex: 0)
                    currentIndex++
                }
                backward = true
            }
            
            if cache.count - currentIndex < threshold {
                // add forward
                let date = cache.last![7].date
                
                for i in 1 ..< 11 {
                    let month = date.dayInTheFollowingMonth(i)
                    let dates = genarator.genarateCalendarDate(month)
                    cache.append(dates)
                }
                forward = true
            }
            
            if maxCacheSize < cache.count {
                // clean cache
                let rest = cache.count - maxCacheSize
                if forward {
                    for _ in 0 ..< rest {
                        cache.removeFirst()
                        currentIndex--
                    }
                } else if backward {
                    for _ in 0 ..< rest {
                        cache.removeLast()
                    }
                } else {
                    assert(true, "cache overflow")
                }
            }
        }
    }
    
    private var cache = [[CalendarDate]]()
    
    override init() {
        genarator = CalendarGenarator()
    }
    
    func backward() -> [CalendarDate] {
        let index = currentIndex - 1
        let rst = cache[index]
        currentIndex = index
        
        return rst
    }
    
    func forward() -> [CalendarDate] {
        let index = currentIndex + 1
        let rst = cache[index]
        currentIndex = index
        
        return rst
    }
    
    func current() -> [CalendarDate] {
        return cache[currentIndex]
    }
    
    func reset(date: NSDate) {
        cache.removeAll()
        
        let dates = genarator.genarateCalendarDate(date)
        cache.append(dates)
        currentIndex = 0
    }
}
