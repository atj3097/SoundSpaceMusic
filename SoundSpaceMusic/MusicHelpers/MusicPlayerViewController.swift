//
//  MusicPlayerViewController.swift
//  SoundSpaceMusic
//
//  Created by God on 3/8/20.
//  Copyright © 2020 Adam Jackson. All rights reserved.
//

import UIKit
import SceneKit
class MusicPlayerViewController: UIViewController {
    let musicPlayerView = MusicPlayerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(musicPlayerView)
    }
    

}
