//
//  CalendarMonthHeaderView.swift
//  Calendar
//
//  Created by  lifirewolf on 16/3/5.
//  Copyright © 2016年 lifirewolf. All rights reserved.
//

import UIKit

let CanlendarTheme = UIColor(red: 26/255.0, green: 168/255.0, blue: 186/255.0, alpha: 1)
let CanlendarTheme1 = UIColor.redColor()

class CalendarMonthHeaderView: UICollectionReusableView {
    
    var masterLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        initView()
    }
    
    func initView() {
        
        let texts = ["日", "一", "二", "三", "四", "五", "六"]
        
        clipsToBounds = true
        // 月份
        masterLabel = UILabel()
        masterLabel.backgroundColor = UIColor.clearColor()
        masterLabel.textAlignment = NSTextAlignment.Center
        masterLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        
        masterLabel.textColor = CanlendarTheme
        addSubview(masterLabel)

        masterLabel.translatesAutoresizingMaskIntoConstraints = false
        
        var c1 = NSLayoutConstraint(item: masterLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        var c2 = NSLayoutConstraint(item: masterLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 16)
        
        addConstraints([c1, c2])
        
        // 一，二，三，四，五，六，日
        var textFields = [UILabel]()
        
        for var i = 0; i < texts.count; i++ {
            
            let dayOfTheWeekLabel = UILabel()
            dayOfTheWeekLabel.backgroundColor = UIColor.clearColor()
            dayOfTheWeekLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
            dayOfTheWeekLabel.textAlignment = NSTextAlignment.Center
            dayOfTheWeekLabel.text = texts[i]
            dayOfTheWeekLabel.textColor = CanlendarTheme
            
            dayOfTheWeekLabel.translatesAutoresizingMaskIntoConstraints = false
            
            addSubview(dayOfTheWeekLabel)
            textFields.append(dayOfTheWeekLabel)
        }
        
        textFields.first?.textColor = CanlendarTheme1
        textFields.last?.textColor = CanlendarTheme1
        
        var tf = textFields.first!
        c1 = NSLayoutConstraint(item: tf, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
        c2 = NSLayoutConstraint(item: tf, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
        var c3 = NSLayoutConstraint(item: tf, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 20)
        tf.addConstraint(c3)
        
        addConstraints([c1, c2])
        
        for var i = 0; i < textFields.count - 1; i++ {
            
            let tf1 = textFields[i]
            let tf2 = textFields[i+1]
            
            c1 = NSLayoutConstraint(item: tf1, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: tf2, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
            c2 = NSLayoutConstraint(item: tf1, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: tf2, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0)
            c3 = NSLayoutConstraint(item: tf1, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: tf2, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0)
            let c4 = NSLayoutConstraint(item: tf1, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: tf2, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
            
            addConstraints([c1, c2, c3, c4])
        }
        
        tf = textFields.last!
        c1 = NSLayoutConstraint(item: tf, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)
        
        addConstraint(c1)
    }
}
