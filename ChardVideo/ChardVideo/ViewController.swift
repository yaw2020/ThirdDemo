//
//  ViewController.swift
//  ChardVideo
//
//  Created by ChardLl on 2017/10/27.
//  Copyright © 2017年 com.chard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let playerHeight = view.bounds.size.width * 9 / 16
//        let playerView = VideoPlayerView(frame: CGRect(x: 0, y: 20, width: view.bounds.size.width, height: playerHeight))
//        view.addSubview(playerView)
    }
    
    let videoTool: videoLauncher = videoLauncher()
    
    @IBAction func launchVideo(_ sender: UIButton) {
        print("...")
        
        videoTool.showVideo { (isComplete) in
            print("complete")
        }
    }
}



