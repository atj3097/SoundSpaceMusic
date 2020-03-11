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


enum isPlaying {
    case playing
    case notPlaying
}

enum VolumePresent{
    case volumeIsChanging
    case volumeIsDone
}

enum RewindOrSkipBack {
    case rewindToBeginning
    case skipToPreviousSong
}

class MusicPlayerView: UIView {
    
    private var isMusicPlaying: isPlaying!
    private var isVolumeChanging: VolumePresent!
    private var rewindOrPrev: RewindOrSkipBack!
    var playerMP3: MP3Player?
    var timer:Timer?
    var audioManager: AudioManager!
    
    //MARK: UI Objects
    lazy var volumeView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var volumeBar: VolumeSlider = {
        let slider = VolumeSlider()
        slider.setInitialValues(audioPlayer: playerMP3!.player!)
        slider.addTarget(self, action: #selector(changeVolume), for: .touchUpInside)
        return slider
    }()
    
    lazy var volumeButton: UIButton =  {
        let button = UIButton()
        let image = #imageLiteral(resourceName: "icons8-low-volume-100")
        button.setImage(image, for: .normal)
        UIUtilities.setUpButton(button, title: "", backgroundColor: .clear, target: self, action: #selector(showVolumeBar))
        return button
    }()
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
    
    lazy var audioScrubber: MusicPlayerScrubber = {
        let progress = MusicPlayerScrubber()
        progress.customizeSlider(audioPlayer: playerMP3!.player! )
        progress.addTarget(self, action: #selector(tryScrubbing), for: .touchUpInside)
        return progress
    }()
    
    lazy var currentLabel: UILabel = {
        let label = UILabel()
        UIUtilities.setUILabel(label, labelTitle: "\(audioScrubber.value)", size: 20, alignment: .left)
        return label
    }()
    
    lazy var menuButton: UIButton = {
        let button = UIButton()
        UIUtilities.setUpButton(button, title: "", backgroundColor: .clear, target: self, action: #selector(showMenu))
        let image = #imageLiteral(resourceName: "menu")
        button.setImage(image, for: .normal)
        return button
    }()
    
    //MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
        audioManager = CoreAudioManager()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    
    }
    
    private func commonInit() {
        playerMP3 = MP3Player()
        let tap = UITapGestureRecognizer(target: self, action: #selector(rewindMusicTapGesture(gesture:)))
        playerMP3?.audioScrubber = audioScrubber
        isVolumeChanging = .volumeIsDone
        rewindOrPrev = .rewindToBeginning
        audioScrubber.maximumValue = Float((playerMP3?.player!.duration)!)
        addSubViews()
        rewindButton.addGestureRecognizer(tap)
        volumeView.isHidden = true
        volumeBar.isHidden = true
        layoutConstraints()
        isMusicPlaying = .notPlaying
        updateViews()
        backgroundColor = SoundSpaceColors.white
        songCover.layer.shadowColor = UIColor(red: 35/255, green: 46/255, blue: 33/255, alpha: 1).cgColor
        songCover.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        songCover.layer.shadowOpacity = 0.9
        songCover.layer.shadowRadius = 4
        volumeView.layer.shadowColor = UIColor(red: 35/255, green: 46/255, blue: 33/255, alpha: 1).cgColor
        volumeView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        volumeView.layer.shadowOpacity = 0.9
        volumeView.layer.shadowRadius = 4
        
    }
    //MARK: Private Functions
    func addSubViews() {
        [songArtists,songCover,playButton,rewindButton,skipSongButton,audioScrubber,songArtists,songTitle,currentLabel,downButton,volumeView, volumeBar, volumeButton].forEach({addSubview($0)})
    }
    
    
    func layoutConstraints() {
        volumeView.snp.makeConstraints{ make in
            make.top.equalTo(songCover)
            make.left.equalTo(songCover)
            make.width.equalTo(songCover)
            make.height.equalTo(50)
        }
        
        volumeBar.snp.makeConstraints{ make in
            make.top.equalTo(volumeView)
            make.left.equalTo(volumeView)
            make.width.equalTo(volumeView)
            make.height.equalTo(volumeView)
        }
        
        songCover.snp.makeConstraints{ make in
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(75)
            make.width.equalTo(self).dividedBy(1.05)
            make.height.equalTo(self).dividedBy(2.5)
        }
        
        volumeButton.snp.makeConstraints{ make in
            make.right.equalTo(songCover)
            make.bottom.equalTo(songArtists)
            make.width.equalTo(30)
            make.height.equalTo(30)
            
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
        
        audioScrubber.snp.makeConstraints{ make in
            make.top.equalTo(songArtists).offset(50)
            make.width.equalTo(self).dividedBy(1.09)
            make.left.equalTo(self).offset(20)
        }
        
        currentLabel.snp.makeConstraints{ make in
            make.centerX.equalTo(self)
            make.top.equalTo(audioScrubber).offset(25)
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
    //MARK: Music Functions
    func setTrackName(){
          songArtists.text = playerMP3?.getCurrentTrackName()
       }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 01.0, target: self, selector: #selector(updateViewsWithTimer(theTimer:)), userInfo: nil, repeats: true)
    }
    
    @objc func swipePlayerAway() {
        print("")
    }
    
   @objc func updateViewsWithTimer(theTimer: Timer){
          updateViews()
      }
      
      func updateViews(){
          currentLabel.text = playerMP3?.getCurrentTimeAsString()
          if let progress = playerMP3?.getProgress() {            audioScrubber.value = Float((playerMP3?.player!.currentTime)!)
          }
      }
    //MARK: Objc Functions
  @objc func tryScrubbing() {
    audioScrubber.scrubAudio(sender: audioScrubber, audioPlayer: (playerMP3?.player!)!)
    audioScrubber.updateSlider(audioPlayer: playerMP3!.player!)
    let image = #imageLiteral(resourceName: "pause")
    playButton.setImage(image, for: .normal)
    isMusicPlaying = .playing
    startTimer()
    }
    
    
    @objc func playMusic() {
        switch isMusicPlaying {
        case .notPlaying:
            playerMP3?.play()
            isMusicPlaying = .playing
            startTimer()
            playButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
//            updateSlider()
        case .playing:
            playerMP3?.pause()
            isMusicPlaying = .notPlaying
            playButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        default:
            print("")
        }
    }

    @objc func changeVolume() {
        volumeBar.changeVolume(audioPlayer: playerMP3!.player!)
    }
    @objc func showMenu() {
        
    }
    
    @objc func showVolumeBar() {
//MARK: TO DO: Make this an animated transition
        switch isVolumeChanging {
        case .volumeIsChanging:
            volumeView.isHidden = true
            volumeBar.isHidden = true
            isVolumeChanging = .volumeIsDone
        case .volumeIsDone:
            volumeView.isHidden = false
            volumeBar.isHidden = false
            isVolumeChanging = .volumeIsChanging
        default:
            print("Volume view not showing")
        }
    }
    
    @objc func fastForwardMusic() {
        
    }
    @objc func rewindMusicTapGesture(gesture: UIGestureRecognizer) {
        if let tapGesture = gesture as? UITapGestureRecognizer {
            switch tapGesture.numberOfTouches {
            case 1:
                print("")
                playerMP3?.player?.currentTime = TimeInterval(exactly: 0.0)!
                audioScrubber.updateSlider(audioPlayer: playerMP3!.player!)
                rewindOrPrev = .skipToPreviousSong
            case 2:
                //MARK: Add Go back to previous song functionality
                print("Go to previous song")
            default:
                print("Tap Gesture Not Recognized")
            }
        }
    }
    @objc func rewindMusic() {
        
        switch rewindOrPrev {
        case .rewindToBeginning:
//            guard playerMP3?.player?.currentTime != TimeInterval(0.0) else {
//                rewindOrPrev = .skipToPreviousSong
//                //Call previous song function
//                print("Go back to previous song")
//                return
//            }
            playerMP3?.player?.currentTime = TimeInterval(exactly: 0.0)!
            audioScrubber.updateSlider(audioPlayer: playerMP3!.player!)
            rewindOrPrev = .skipToPreviousSong
        case .skipToPreviousSong:
            //MARK: Add Go back to previous song functionality
            print("Go to previous song")
        default:
            print("No rewind")
        }
        
    }
    
    func updateSlider() {
        audioScrubber.value = Float((playerMP3?.player!.currentTime)!)
    }

}
