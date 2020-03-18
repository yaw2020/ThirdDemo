//
//  VideoLauncher.swift
//  ChardVideo
//
//  Created by ChardLl on 2017/10/30.
//  Copyright © 2017年 com.chard. All rights reserved.
//

import Foundation
import UIKit

class videoLauncher: NSObject {
    
    override init() {
        super.init()
    }
    
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        return view
    }()
    
    var playerView: VideoPlayerView?
    
    func showVideo(completed: @escaping (Bool)->Swift.Void) {
        guard let keyWindow = UIApplication.shared.keyWindow else { return }
        if playerView != nil {
            showAnimation()
            return
        }
        
        backgroundView.frame = CGRect(x: keyWindow.frame.size.width - 10, y: keyWindow.frame.size.height - 10, width: 10, height: 10)
        
        let playerHeight = keyWindow.frame.size.width * 9 / 16
        let playerFrame = CGRect(x: 0, y: 20, width: keyWindow.frame.size.width, height: playerHeight)
        playerView = VideoPlayerView(frame: playerFrame)
        backgroundView.addSubview(playerView!)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panHandler))
        playerView?.addGestureRecognizer(panGesture)
        
        keyWindow.addSubview(backgroundView)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
            self.backgroundView.frame = keyWindow.frame
        }) { (isCompleted) in
            completed(isCompleted)
        }
    }
    
    private var backgroundY: CGFloat = 0.0
    
    @objc private func panHandler(ges: UIPanGestureRecognizer) {
        guard let keyWindow = UIApplication.shared.keyWindow else { return }
        let transition = ges.translation(in: keyWindow)
//        print("transition: ",transition.y)
        if ges.state == .began {
            playerView?.controlsContainerView.isHidden = true
        }
        
        let y = backgroundY + transition.y
        let x = y * (keyWindow.frame.size.width - 160) / (keyWindow.frame.size.height - 90 - 50)
        let w = keyWindow.frame.size.width - x
        let h = keyWindow.frame.size.height - y
        if y < keyWindow.frame.size.height - 90 - 50, y > 0 {
            backgroundView.frame = CGRect(x: x, y: y, width: w, height: h)
            
            let playerW = backgroundView.frame.size.width
            let playerH = playerW * 9 / 16
            playerView?.frame = CGRect(x: 0, y: 0, width: playerW, height: playerH)
        }
        
        if ges.state == .ended {
            backgroundY = backgroundView.frame.origin.y
            showAnimation()
//            print("ended")
        }
    }
    
    private func showAnimation() {
        guard let keyWindow = UIApplication.shared.keyWindow else { return }
        
        if backgroundY >= ((keyWindow.frame.size.height - 50) * 0.5), backgroundY < (keyWindow.frame.size.height - 90 - 50) {
            UIView.animate(withDuration: 0.3, delay: 0, options: .allowUserInteraction, animations: {
                let x: CGFloat = keyWindow.frame.size.width - 160.0
                let y: CGFloat = keyWindow.frame.size.height - 90.0 - 50.0
                let w: CGFloat = 160.0
                let h: CGFloat = 90.0 + 50.0
                self.backgroundView.frame = CGRect(x: x, y: y, width: w, height: h)
                self.playerView?.frame = CGRect(x: 0, y: 0, width: 160, height: 90)
                self.backgroundView.backgroundColor = .clear
            }, completion: { (_) in
                self.backgroundY = self.backgroundView.frame.origin.y
            })
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                let w = keyWindow.frame.size.width
                let h = keyWindow.frame.size.height
                self.backgroundView.frame = CGRect(x: 0, y: 0, width: w, height: h)
                self.playerView?.frame = CGRect(x: 0, y: 20, width: w, height: w * 9 / 16)
                self.backgroundView.backgroundColor = .orange
            }, completion: { (_) in
                self.backgroundY = 0.0
            })
        }
    }
}
