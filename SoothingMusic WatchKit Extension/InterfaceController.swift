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

        player = SCNAudioPlayer(source: source)
        playerNode.addAudioPlayer(player)
    }

    // MARK: WKInterfaceController

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        setUp()
    }

}
