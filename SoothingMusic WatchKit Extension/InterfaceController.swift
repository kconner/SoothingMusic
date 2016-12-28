//
//  InterfaceController.swift
//  SoothingMusic WatchKit Extension
//
//  Created by Kevin Conner on 12/28/16.
//  Copyright © 2016 Kevin Conner. All rights reserved.
//

import WatchKit
import Foundation
import SceneKit

// AVFoundation is not available in the watchOS simulator.
#if !((arch(i386) || arch(x86_64)) && os(watchOS))
    import AVFoundation
#endif

final class InterfaceController: WKInterfaceController {
    
    @IBOutlet var sceneInterface: WKInterfaceSCNScene!

    var player: SCNAudioPlayer!

    private func setUp() {
        guard let source = SCNAudioSource(named: "Larry Owens - Interlude.mp3"),
            let scene = sceneInterface.scene,
            let playerNode = scene.rootNode.childNode(withName: "player", recursively: true) else
        {
            preconditionFailure("RUINED")
        }

        source.loops = true
        source.shouldStream = true
        source.volume = 0.05

        player = SCNAudioPlayer(source: source)
        playerNode.addAudioPlayer(player)

        #if !((arch(i386) || arch(x86_64)) && os(watchOS))
            _ = try? AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        #endif
    }

    // MARK: WKInterfaceController

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        setUp()
    }

    override func didAppear() {
        super.didAppear()

        sceneInterface.scene?.isPaused = false
        
        #if !((arch(i386) || arch(x86_64)) && os(watchOS))
            _ = try? AVAudioSession.sharedInstance().setActive(true)
        #endif
    }

    override func willDisappear() {
        super.willDisappear()

        sceneInterface.scene?.isPaused = true
        
        #if !((arch(i386) || arch(x86_64)) && os(watchOS))
            _ = try? AVAudioSession.sharedInstance().setActive(false)
        #endif
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }

}
