//
//  CalendarCollectionViewController.swift
//  Calendar
//
//  Created by  lifirewolf on 16/3/5.
//  Copyright © 2016年 lifirewolf. All rights reserved.
//

import UIKit

class CalendarCollectionViewController: UIViewController {
    
    struct Static {
        static let MonthHeader = "MonthHeaderView"
        static let DayCell = "DayCell"
    }
    
    var collectionView: UICollectionView!
    
    var calendarMonth = [[CalendarDayModel]]()//每个月份的中的daymodel容器数组
    var logic = CalendarLogic()
    
    override func viewDidLoad() {
        
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: CalendarMonthCollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        let views = ["collectionView": collectionView]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[collectionView]-0-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[collectionView]-0-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
//        collectionView.collectionViewLayout = CalendarMonthCollectionViewLayout()
        
        collectionView.registerClass(CalendarDayCell.self, forCellWithReuseIdentifier: Static.DayCell)
        collectionView.registerClass(CalendarMonthHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Static.MonthHeader)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = UIColor.whiteColor()
        
        calendarMonth = logic.reloadCalendarView(nil, selectDates: [], needDays: 365)
    }
    
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        
        let layout = collectionView.collectionViewLayout as! CalendarMonthCollectionViewLayout
        layout.initSize()
    }
}

extension CalendarCollectionViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return calendarMonth.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendarMonth[section].count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Static.DayCell, forIndexPath: indexPath) as! CalendarDayCell
        
        cell.model = calendarMonth[indexPath.section][indexPath.row]
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        var reusableview: UICollectionReusableView
        
        let model = calendarMonth[indexPath.section][15] // TODO  15
        
        let monthHeader = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: Static.MonthHeader, forIndexPath: indexPath) as! CalendarMonthHeaderView
        
        monthHeader.masterLabel.text = "\(model.year)年 \(model.month)月"
        monthHeader.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.8)
        reusableview = monthHeader
        
        return reusableview
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let model = calendarMonth[indexPath.section][indexPath.row]
        print(model)
        genTips(model)
    }
    
    func genTips(model: CalendarDayModel) {
        switch model.style! {
        case .LastWhole:
                        print("LastWhole")

        case .LastComponent:
                        print("LastComponent")

        case .NextWhole:
                        print("NestWhole")

        case .NextComponent:
                        print("NestComponent")
            
        default :
            break
        }
    }
    
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
}
