//
//  ViewController.swift
//  Calendar
//
//  Created by  lifirewolf on 16/3/5.
//  Copyright © 2016年 lifirewolf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func showcalendar(sender: AnyObject) {
        
        let calendarCollectionViewController = CalendarCollectionViewController()
        
        navigationController?.pushViewController(calendarCollectionViewController, animated: true)
        
    }
}
