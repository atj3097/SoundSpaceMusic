//
//  MusicPlayerView.swift
//  SoundSpaceMusic
//
//  Created by God on 3/8/20.
//  Copyright © 2020 Adam Jackson. All rights reserved.
//

import UIKit
class MusicPlayerView: UIView {
    
    lazy var songCover: UIImageView = {
        let imageView = UIImageView()
        let testImage = #imageLiteral(resourceName: "testCoverArt")
        UIUtilities.setUpImageView(imageView, image: testImage, contentMode: .scaleAspectFit)
        return imageView
    }()
    
    lazy var songTitleLabel: UILabel = {
        let label = UILabel()
        UIUtilities.setUILabel(label, labelTitle: "Rick Ross ft. Drake", size: UIConstants.songtitleSize , alignment: .left)
        return label
    }()
    
    lazy var playButton: UIButton = {
        let button = UIButton()
        UIUtilities.setUpButton(button, title: "", backgroundColor: .clear, target: self, action: #selector(playMusic))
        button.imageView?.image = #imageLiteral(resourceName: "play")
        
        return button
    }()
    
    lazy var pauseButton: UIButton = {
        let pauseButton = UIButton()
        UIUtilities.setUpButton(pauseButton, title: "", backgroundColor: .clear, target: self, action: #selector(pauseMusic))
        pauseButton.imageView?.image = #imageLiteral(resourceName: "pause")
        return pauseButton
    }()
    
    lazy var skipSongButton: UIButton = {
        let button = UIButton()
        UIUtilities.setUpButton(button, title: "", backgroundColor: .clear, target: self, action: #selector(fastForwardMusic))
        button.imageView?.image = #imageLiteral(resourceName: "foward")
        return button
    }()
    
    lazy var rewindButton: UIButton = {
        let button = UIButton()
        UIUtilities.setUpButton(button,title: "", backgroundColor: .clear, target: self, action: #selector(rewindMusic))
        button.imageView?.image = #imageLiteral(resourceName: "rewind")
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
        
    }
    
    @objc func playMusic() {
        
    }
    
    @objc func pauseMusic() {
        
    }
    
    @objc func fastForwardMusic() {
        
    }
    
    @objc func rewindMusic() {
        
    }
    
    
}






