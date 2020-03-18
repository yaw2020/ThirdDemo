//
//  VideoPlayerView.swift
//  ChardVideo
//
//  Created by ChardLl on 2017/10/27.
//  Copyright © 2017年 com.chard. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    
    let controlsContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let indicatorView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.startAnimating()
        return activityView
    }()
    
    let titleLab: UILabel = {
        let lab = UILabel()
        lab.textAlignment = .left
        lab.text = "这是一部片"
        lab.textColor = .white
        return lab
    }()
    
    let currentTimeLab: UILabel = {
        let lab = UILabel()
        lab.textAlignment = .center
        lab.text = "0:00"
        lab.textColor = .white
        return lab
    }()
    
    let totalTimeLab: UILabel = {
        let lab = UILabel()
        lab.textAlignment = .center
        lab.text = "0:00"
        lab.textColor = .white
        return lab
    }()
    
    let sliderView: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        slider.setThumbImage(UIImage(named: "thumb"), for: UIControlState())
        
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        
        return slider
    }()
    
    @objc private func handleSliderChange() {
        
        if let duration = player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            if totalSeconds > 0.0 {
                let value = Float64(sliderView.value) * Float64(totalSeconds)
                
                let seekTime = CMTime(value: Int64(value), timescale: 1)
                
                player?.seek(to: seekTime, completionHandler: { (completedSeek) in
                    //perhaps do something later here
                    self.player?.play()
                })
            }
        }
    }
    
    let playButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        button.addTarget(self, action: #selector(playButtonHandler), for: .touchUpInside)
        
        button.isHidden = true
        
        return button
    }()
    
    var isPlaying: Bool = false
    
    @objc private func playButtonHandler() {
        if isPlaying {
            player?.pause()
            playButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        } else {
            player?.play()
            playButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        }
        
        isPlaying = !isPlaying
    }
    
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPlayer()
        
        setupGradientLayer()

        addSubview(indicatorView)
        addSubview(controlsContainerView)
        controlsContainerView.frame = self.bounds
        
        controlsContainerView.addSubview(playButton)
        controlsContainerView.addSubview(currentTimeLab)
        controlsContainerView.addSubview(sliderView)
        controlsContainerView.addSubview(totalTimeLab)
        controlsContainerView.addSubview(titleLab)
        
        indicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        indicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        playButton.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        playButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        playButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        currentTimeLab.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: 0, height: 0)
        
        sliderView.anchor(top: nil, left: currentTimeLab.rightAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 9, paddingRight: 8, width: 0, height: 0)
        
        totalTimeLab.anchor(top: nil, left: sliderView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: 0, height: 0)
        
        titleLab.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        self.addGestureRecognizer(tap)
    }
    
    @objc private func tapHandler() {
        if controlsContainerView.isHidden {
            controlsContainerView.isHidden = false
            UIView.animate(withDuration: 0.3, animations: {
                self.controlsContainerView.alpha = 1
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.controlsContainerView.alpha = 0
            }, completion: { (completed) in
                self.controlsContainerView.isHidden = true
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPlayer() {
        
        backgroundColor = .black
        
        let urlString = "http://7xr4xn.media1.z0.glb.clouddn.com/snh48sxhsy.mp4"
        guard let videoUrl = URL(string: urlString) else { return }
        
        player = AVPlayer(url: videoUrl)
        
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.videoGravity = .resizeAspectFill
        playerLayer?.frame = bounds
        layer.addSublayer(playerLayer!)
        
        player?.play()
        
        player?.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        
        let interval = CMTime(value: 1, timescale: 2)
        player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
            
            let seconds = CMTimeGetSeconds(progressTime)
            let secondsString = String(format: "%02d", Int(seconds.truncatingRemainder(dividingBy: 60)))
            let minutesString = String(format: "%02d", Int(seconds / 60))
            
            self.currentTimeLab.text = "\(minutesString):\(secondsString)"
            
            //lets move the slider thumb
            if let duration = self.player?.currentItem?.duration {
                let durationSeconds = CMTimeGetSeconds(duration)
                
                self.sliderView.value = Float(seconds / durationSeconds)
                
            }
        })
    }
    
    let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.black.cgColor]
        layer.locations = [-0.6, 0.3, 0.7, 1.6]
        return layer
    }()
    
    private func setupGradientLayer() {
        controlsContainerView.layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        CATransaction.begin()
        if let animation = layer.animation(forKey: "position") {
            CATransaction.setAnimationDuration(animation.duration)
            CATransaction.setAnimationTimingFunction(animation.timingFunction)
        } else {
            CATransaction.setDisableActions(true)
        }
        if playerLayer?.superlayer == layer {
            playerLayer?.frame = bounds
            gradientLayer.frame = bounds
        }
        CATransaction.commit()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "status", player?.status == .readyToPlay {
            indicatorView.stopAnimating()
            playButton.isHidden = false
            isPlaying = true
            
            print("status")
        }
        
        if keyPath == "currentItem.loadedTimeRanges" {
            
            if let duration = player?.currentItem?.duration {
                let seconds = CMTimeGetSeconds(duration)
                
                let secondsText = Int(seconds) % 60
                let minutesText = String(format: "%02d", Int(seconds) / 60)
                totalTimeLab.text = "\(minutesText):\(secondsText)"
            }
        }
    }
}
