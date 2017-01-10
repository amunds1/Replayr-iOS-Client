//
//  LandscapeAVPlayerController.swift
//  replayr
//
//  Created by Andreas Amundsen on 10/01/2017.
//  Copyright © 2017 amundsencode. All rights reserved.
//

import AVKit

class LandscapeAVPlayerController: AVPlayerViewController {
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeLeft
    }
    
}
