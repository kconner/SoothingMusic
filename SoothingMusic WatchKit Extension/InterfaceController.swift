//
//  InterfaceController.swift
//  SoothingMusic WatchKit Extension
//
//  Created by Kevin Conner on 12/28/16.
//  Copyright © 2016 Kevin Conner. All rights reserved.
//

import WatchKit
import Foundation
import AVFoundation

final class InterfaceController: WKInterfaceController {
    
    @IBOutlet var sceneInterface: WKInterfaceSCNScene!

    private var engine: AVAudioEngine!
    private var player: AVAudioPlayerNode!
    private var audioFile: AVAudioFile!

    // MARK: WKInterfaceController

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        engine = AVAudioEngine()

        player = AVAudioPlayerNode()
        engine.attach(player)

        let stereoFormat = AVAudioFormat(standardFormatWithSampleRate: 44100.0, channels: 2)
        engine.connect(player, to: engine.mainMixerNode, format: stereoFormat)

        do {
            let url = Bundle.main.url(forResource: "Larry Owens - Interlude", withExtension: "mp3")!
            audioFile = try AVAudioFile(forReading: url)
        } catch {
            preconditionFailure("RUINED")
        }

        do {
            if !engine.isRunning {
                try engine.start()
            }
        } catch {
            preconditionFailure("RUINED")
        }

        player.scheduleFile(audioFile, at: nil, completionHandler: nil)
    }

    override func willActivate() {
        super.willActivate()

        player.play()
    }

    override func didDeactivate() {
        super.didDeactivate()

        player.stop()
    }

}
