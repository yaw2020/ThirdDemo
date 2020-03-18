//
//  CalendarDayCell.swift
//  Calendar
//
//  Created by  lifirewolf on 16/3/5.
//  Copyright © 2016年 lifirewolf. All rights reserved.
//

import UIKit

class CalendarDayCell: UICollectionViewCell {
    
    
    var day_lab: UILabel!        // 今天的日期或者是节日
    var day_title: UILabel!      // 显示标签
    var imgview: UIImageView!    // 选中时的图片
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView()  {
        
        // 日期
        day_lab = UILabel()
        day_lab.textAlignment = NSTextAlignment.Center
        day_lab.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        day_lab.translatesAutoresizingMaskIntoConstraints = false
        
        var c1 = NSLayoutConstraint(item: day_lab, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        var c2 = NSLayoutConstraint(item: day_lab, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        
        var c3 = NSLayoutConstraint(item: day_lab, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 36)
        var c4 = NSLayoutConstraint(item: day_lab, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 36)
        day_lab.addConstraints([c3, c4])
        
        addSubview(day_lab)
        addConstraints([c1, c2])
        
        //选中时显示的图片
        imgview = UIImageView(image: UIImage(named: "check.png"))
        imgview.translatesAutoresizingMaskIntoConstraints = false
        
        c1 = NSLayoutConstraint(item: imgview, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: day_lab, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 5)
        c2 = NSLayoutConstraint(item: imgview, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: day_lab, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 5)
        c3 = NSLayoutConstraint(item: imgview, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: day_lab, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: -5)
        c4 = NSLayoutConstraint(item: imgview, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: day_lab, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: -5)
        
        insertSubview(imgview, belowSubview: day_lab)
        addConstraints([c1, c2, c3, c4])
        
        //农历
        day_title = UILabel()
        day_title.translatesAutoresizingMaskIntoConstraints = false
        day_title.textColor = UIColor.lightGrayColor()
        day_title.font = UIFont.boldSystemFontOfSize(11)
        day_title.textAlignment = NSTextAlignment.Center
        
        c1 = NSLayoutConstraint(item: day_title, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        c2 = NSLayoutConstraint(item: day_title, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: day_lab, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: -6)
        
        addSubview(day_title)
        addConstraints([c1, c2])
    }
    
    func hiddenItem() {
        day_lab.hidden = true
        day_title.hidden = true
        imgview.hidden = true
    }
    
    func showItem() {
        day_lab.hidden = false
        day_title.hidden = false
    }
    
    var model: CalendarDayModel! {
        didSet {
            switch model.style! {
            case .Empty:    // 不显示
                hiddenItem()
                
            case .Past: // 过去的日期
                showItem()
                day_lab.text = "\(model.day!)"
                if model.holiday != nil {
                    day_title.text = model.holiday
                } else {
                    day_title.text = model.Chinese_calendar
                }
                day_lab.textColor = UIColor.lightGrayColor()
                day_title.textColor = UIColor.lightGrayColor()
                
                imgview.hidden = true
                
            case .Futur: // 将来的日期
                showItem()
                day_lab.text = "\(model.day)"
                if model.holiday != nil {
                    day_title.text = model.holiday
                    day_lab.textColor = UIColor.orangeColor()
                } else {
                    day_title.text = model.Chinese_calendar
                    day_lab.textColor = CanlendarTheme
                }
                
                imgview.hidden = true
                
            case .Week: // 周末
                showItem()
                day_lab.text = "\(model.day)"
                if model.holiday != nil {
                    day_title.text = model.holiday
                    day_lab.textColor = UIColor.orangeColor()
                } else {
                    day_title.text = model.Chinese_calendar
                    day_lab.textColor = CanlendarTheme1
                }
                
                imgview.hidden = true
                
            case .Click, .LastWhole, .LastComponent, .NextWhole, .NextComponent, .WhatEver: // 被点击的日期
                showItem()
                day_lab.text = "\(model.day)"
                day_lab.textColor = UIColor.whiteColor()
                if model.holiday != nil {
                    day_title.text = model.holiday
                } else {
                    day_title.text = model.Chinese_calendar
                }
                imgview.hidden = false
            }
        }
    }

}