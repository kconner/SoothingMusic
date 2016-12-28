//
//  InterfaceController.swift
//  SoothingMusic WatchKit Extension
//
//  Created by Kevin Conner on 12/28/16.
//  Copyright © 2016 Kevin Conner. All rights reserved.
//

import WatchKit
import Foundation

final class InterfaceController: WKInterfaceController {

    @IBOutlet private var pauseButton: WKInterfaceButton!

    private var buttonTitle = "" {
        didSet {
            pauseButton.setTitle(buttonTitle)
        }
    }

    private var player: WKAudioFilePlayer!

    // MARK: Helpers

    @IBAction private func didTapPauseButton() {
        if player.rate == 0.0 {
            player.play()
        } else {
            player.pause()
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
        
        let url = Bundle.main.url(forResource: "Larry Owens - Interlude", withExtension: "mp3")!
        let asset = WKAudioFileAsset(url: url)
        player = WKAudioFilePlayer(playerItem: WKAudioFilePlayerItem(asset: asset))
        player.play()
    }

}
