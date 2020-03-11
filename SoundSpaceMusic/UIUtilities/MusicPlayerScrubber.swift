//
//  MusicPlayerScrubber.swift
//  SoundSpaceMusic
//
//  Created by God on 3/10/20.
//  Copyright © 2020 Adam Jackson. All rights reserved.
//

import UIKit
import AVFoundation

class MusicPlayerScrubber: UISlider {
    //Sets minimum and maximum of Scrubber based on length of song
    func customizeSlider(audioPlayer: AVAudioPlayer) {
        tintColor = .white
//        minimumValue = 0
//        maximumValue = Float(audioPlayer.duration)
    }
    
    //Goes through the audio - allows to skip or rewind
    func scrubAudio(sender: AnyObject, audioPlayer: AVAudioPlayer) {
        audioPlayer.stop()
        audioPlayer.currentTime = TimeInterval(value)
        print(value)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    //Updates the current time of the label in the player
    func updateTime(currentTimeLabel: UILabel, audioPlayer: AVAudioPlayer) {
        let currentTime = Int(audioPlayer.currentTime)
        let duration = Int(audioPlayer.duration)
        let total = currentTime - duration
        _ = String(total)
        
        let minutes = currentTime/60
        var seconds = currentTime - minutes / 60
        if minutes > 0 {
            seconds = seconds - 60 * minutes
        }
        
        currentTimeLabel.text = NSString(format: "%02d:%02d", minutes,seconds) as String
    }
    
    //Increments the audio slider 
    func updateSlider(audioPlayer: AVAudioPlayer) {
        value += Float(audioPlayer.currentTime)
    }
    
    
}
