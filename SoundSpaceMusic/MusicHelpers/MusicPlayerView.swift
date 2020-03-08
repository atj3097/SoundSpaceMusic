//
//  MusicPlayerView.swift
//  SoundSpaceMusic
//
//  Created by God on 3/8/20.
//  Copyright © 2020 Adam Jackson. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation
import AudioKit

enum isPlaying {
    case playing
    case notPlaying
}

class MusicPlayerView: UIView {
    
    private var isMusicPlaying: isPlaying!
    var mp3Player: MP3Player?
    var timer:Timer?
    var audioKitReader: AKAudioFile?
    
    lazy var songCover: UIImageView = {
        let imageView = UIImageView()
        let testImage = #imageLiteral(resourceName: "coverArt")
        UIUtilities.setUpImageView(imageView, image: testImage, contentMode: .redraw)
        return imageView
    }()
    
    lazy var songTitle: UILabel = {
        let label = UILabel()
    UIUtilities.setUILabel(label, labelTitle: "Gold Roses", size: UIConstants.songtitleSize , alignment: .left)
        return label
    }()
    
    lazy var songArtists: UILabel = {
        let label = UILabel()
        UIUtilities.setUILabel(label, labelTitle: "Rick Ross ft. Drake", size: 20 , alignment: .left)
        return label
    }()
    
    lazy var playButton: UIButton = {
        let button = UIButton()
        UIUtilities.setUpButton(button, title: "", backgroundColor: .clear, target: self, action: #selector(playMusic))
        let image = #imageLiteral(resourceName: "play")
        button.setImage(image, for: .normal)
        return button
    }()
    
    lazy var skipSongButton: UIButton = {
        let button = UIButton()
        UIUtilities.setUpButton(button, title: "", backgroundColor: .clear, target: self, action: #selector(fastForwardMusic))
        let image = #imageLiteral(resourceName: "foward")
        button.setImage(image, for: .normal)
        return button
    }()
    
    lazy var rewindButton: UIButton = {
        let button = UIButton()
        UIUtilities.setUpButton(button,title: "", backgroundColor: .clear, target: self, action: #selector(rewindMusic))
        let image = #imageLiteral(resourceName: "rewind")
        button.setImage(image, for: .normal)
        return button
    }()
    
    lazy var downButton: UIButton = {
        let button = UIButton()
        UIUtilities.setUpButton(button, title: "", backgroundColor: .clear, target: self, action: #selector(swipePlayerAway))
        let image = #imageLiteral(resourceName: "down")
        button.setImage(image, for: .normal)
        return button
    }()
    
    lazy var timeSlider: UIProgressView = {
        let progress = UIProgressView()
        progress.tintColor = .white
        return progress
    }()
    
    lazy var currentLabel: UILabel = {
        let label = UILabel()
        UIUtilities.setUILabel(label, labelTitle: "\(timeSlider.progress)", size: 20, alignment: .left)
        return label
    }()
    
    lazy var menuButton: UIButton = {
        let button = UIButton()
        UIUtilities.setUpButton(button, title: "", backgroundColor: .clear, target: self, action: #selector(showMenu))
        let image = #imageLiteral(resourceName: "menu")
        button.setImage(image, for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    
    }
    
    private func commonInit() {
        addSubViews()
        layoutConstraints()
        mp3Player = MP3Player()
        isMusicPlaying = .notPlaying
        updateViews()
        backgroundColor = .darkGray
        songCover.layer.shadowColor = UIColor(red: 35/255, green: 46/255, blue: 33/255, alpha: 1).cgColor
        songCover.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        songCover.layer.shadowOpacity = 0.9
        songCover.layer.shadowRadius = 4
        
    }
    
    func addSubViews() {
        [songArtists,songCover,playButton,rewindButton,skipSongButton,timeSlider,songArtists,songTitle,currentLabel,downButton].forEach({addSubview($0)})
    }
    
    
    func layoutConstraints() {
        
        songCover.snp.makeConstraints{ make in
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(75)
            make.width.equalTo(self).dividedBy(1.05)
            make.height.equalTo(self).dividedBy(2.5)
        }
        
        songTitle.snp.makeConstraints{ make in
            make.bottom.equalTo(songArtists).offset(-25)
            make.left.equalTo(self).offset(20)
            make.width.equalTo(self)
        }
        
        songArtists.snp.makeConstraints{ make in
            make.left.equalTo(self).offset(20)
            make.width.equalTo(self)
            make.bottom.equalTo(songCover).offset(70)
        }
        
        timeSlider.snp.makeConstraints{ make in
            make.top.equalTo(songArtists).offset(50)
            make.width.equalTo(self).dividedBy(1.09)
            make.left.equalTo(self).offset(20)
        }
        
        currentLabel.snp.makeConstraints{ make in
            make.centerX.equalTo(self)
            make.top.equalTo(timeSlider).offset(25)
        }
        
        playButton.snp.makeConstraints{ make in
            make.top.equalTo(songArtists).offset(125)
            make.centerX.equalTo(self)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        skipSongButton.snp.makeConstraints{ make in
            make.right.equalTo(playButton).offset(100)
            make.centerY.equalTo(playButton)
            make.top.equalTo(playButton)
            make.width.equalTo(playButton)
            make.height.equalTo(playButton)
        }
        
        rewindButton.snp.makeConstraints{ make in
            make.top.equalTo(playButton)
            make.left.equalTo(playButton).offset(-100)
            make.centerY.equalTo(playButton)
            make.width.equalTo(playButton)
            make.height.equalTo(playButton)
        }
        
        
        
        downButton.snp.makeConstraints{ make in
            make.bottom.equalTo(self)
            make.centerX.equalTo(self)
            make.height.equalTo(playButton)
            make.width.equalTo(playButton)
        }
    }
    
    func setTrackName(){
          songArtists.text = mp3Player?.getCurrentTrackName()
       }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateViewsWithTimer(theTimer:)), userInfo: nil, repeats: true)
    }
    
    @objc func swipePlayerAway() {
        print("")
    }
    
   @objc func updateViewsWithTimer(theTimer: Timer){
          updateViews()
      }
      
      func updateViews(){
          currentLabel.text = mp3Player?.getCurrentTimeAsString()
          if let progress = mp3Player?.getProgress() {
              timeSlider.progress = progress
          }
      }
    
    
    @objc func playMusic() {
        switch isMusicPlaying {
        case .notPlaying:
            mp3Player?.play()
            isMusicPlaying = .playing
            startTimer()
            playButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        case .playing:
            mp3Player?.pause()
            isMusicPlaying = .notPlaying
            playButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        default:
            print("")
        }
    }

    
    @objc func showMenu() {
        
    }
    
    @objc func fastForwardMusic() {
        
    }
    
    @objc func rewindMusic() {
        
    }
    
    
}








