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

    @IBOutlet private var pauseButton: WKInterfaceButton!

    private var buttonTitle = "" {
        didSet {
            pauseButton.setTitle(buttonTitle)
        }
    }

    private var engine: AVAudioEngine!
    private var player: AVAudioPlayerNode!
    private var audioFile: AVAudioFile!

    // MARK: Helpers

    @IBAction private func didTapPauseButton() {
        if player.isPlaying {
            player.pause()
        } else {
            player.play()
        }

        var title: String
        repeat {
            title = Titles.random
        } while title == buttonTitle
        buttonTitle = title
    }
    
    // MARK: WKInterfaceController

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        buttonTitle = Titles.random

        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)

            engine = AVAudioEngine()

            player = AVAudioPlayerNode()
            engine.attach(player)

            let stereoFormat = AVAudioFormat(standardFormatWithSampleRate: 44100.0, channels: 2)
            engine.connect(player, to: engine.mainMixerNode, format: stereoFormat)

            let url = Bundle.main.url(forResource: "Larry Owens - Interlude", withExtension: "mp3")!
            audioFile = try AVAudioFile(forReading: url)
            
            if !engine.isRunning {
                try engine.start()
            }
        } catch {
            preconditionFailure("RUINED")
        }

        player.scheduleFile(audioFile, at: nil, completionHandler: nil)
        player.play()
    }

    override func willActivate() {
        super.willActivate()

        try! AVAudioSession.sharedInstance().setActive(true)
    }

}
