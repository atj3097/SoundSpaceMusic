//
//  MusicPlayerHelper.swift
//  SoundSpaceMusic
//
//  Created by God on 3/8/20.
//  Copyright © 2020 Adam Jackson. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class MP3Player: NSObject, AVAudioPlayerDelegate {
    var audioScrubber: MusicPlayerScrubber!
    var player: AVAudioPlayer?
    var currentTrackIndex = 0
    var tracks:[String] = [String]()
    
    override init(){
        tracks = FileReader.readFiles()
        super.init()
        queueTrack();
        
    }
    
    func queueTrack(){
        
        if(player != nil){
            player = nil
        }
        
        var error:NSError?
        let url = NSURL.fileURL(withPath: tracks[currentTrackIndex] as String)
//        player = AVAudioPlayer(contentsOfURL: url, error: &error)
        do {
     try   player = AVAudioPlayer(contentsOf: url)
        }
        catch {
            print("error")
        }
    
        
            if let hasError = error {
            //SHOW ALERT OR SOMETHING
            } else {
                player?.delegate = self
                player?.prepareToPlay()
            }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SetTrackNameText"), object: nil)
      }
    
    func play() {
        if player?.isPlaying == false {
             player?.play()
            audioScrubber.updateSlider(audioPlayer: player!)
    }
        
    }
    
    func stop(){
        if player?.isPlaying == true {
            player?.stop()
            player?.currentTime = 0
        }
    }
    
    func pause(){
        if player?.isPlaying == true{
            player?.pause()
        }
    }
    
    func nextSong(songFinishedPlaying:Bool){
        var playerWasPlaying = false
        if player?.isPlaying == true {
            player?.stop()
            playerWasPlaying = true
        }

        currentTrackIndex += 1
        if currentTrackIndex >= tracks.count {
            currentTrackIndex = 0
        }
        queueTrack()
        if playerWasPlaying || songFinishedPlaying {
            player?.play()
        }
        
    }
    
    func previousSong(){
        var playerWasPlaying = false
        if player?.isPlaying == true {
            player?.stop()
            playerWasPlaying = true
        }
        currentTrackIndex -= 1
        if currentTrackIndex < 0 {
            currentTrackIndex = tracks.count - 1
        }
        
        queueTrack()
        if playerWasPlaying {
            player?.play()
        }
    }
    
    func getCurrentTrackName() -> String {
//        let trackName = tracks[currentTrackIndex].lastPathComponent.stringByDeletingPathExtension
        let name = tracks[currentTrackIndex]
        return name
    }

    
    func getCurrentTimeAsString() -> String {
        var seconds = 0
        var minutes = 0
        if let time = player?.currentTime {
            seconds = Int(time) % 60
            minutes = (Int(time) / 60) % 60
        }
        return String(format: "%0.2d:%0.2d",minutes,seconds)
   }
    
    func getProgress()->Float{
        var theCurrentTime = 0.0
        var theCurrentDuration = 0.0
        if let currentTime = player?.currentTime, let duration = player?.duration {
            theCurrentTime = currentTime
            theCurrentDuration = duration
        }
        
        return Float(theCurrentTime / theCurrentDuration)
    }
    
    func setVolume(volume:Float){
        player?.volume = volume
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer,
        successfully flag: Bool){
            if flag == true {
                nextSong(songFinishedPlaying: true)
           }
    }
}

class FileReader: NSObject {
    class func readFiles() -> [String] {
        return  Bundle.main.paths(forResourcesOfType: "mp3", inDirectory: nil)
    }
}
