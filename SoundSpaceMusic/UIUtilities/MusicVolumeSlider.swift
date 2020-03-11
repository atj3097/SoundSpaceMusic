//
//  MusicVolumeSlider.swift
//  SoundSpaceMusic
//
//  Created by God on 3/11/20.
//  Copyright © 2020 Adam Jackson. All rights reserved.
//

import UIKit
import AVFoundation
class VolumeSlider: UISlider {
    
    func setInitialValues(audioPlayer: AVAudioPlayer) {
        minimumValue = 0.0
        maximumValue = audioPlayer.volume
        tintColor = SoundSpaceColors.lightGreen
        value = audioPlayer.volume
    }
    func changeVolume(audioPlayer: AVAudioPlayer) {
        audioPlayer.volume = value
    }
}
