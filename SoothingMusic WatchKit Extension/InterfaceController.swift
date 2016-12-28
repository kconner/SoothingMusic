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

    var randomButtonTitle: String {
        switch arc4random_uniform(8) {
        case 0:
            return "Black gesso"
        case 1:
            return "GG"
        case 2:
            return "Why doesn't Bob\nread chat?"
        case 3:
            return "Everybody\nneeds a friend"
        case 4:
            return "Just tap"
        case 5:
            return "This is\nyour world"
        case 6:
            return "You don't want\ntoo much green"
        case 7:
            return "Anybody can do it"
        default:
            return "RUINED"
        }
    }

    @IBAction private func didTapPauseButton() {
        if player.rate == 0.0 {
            player.play()
        } else {
            player.pause()
        }

        var title: String
        repeat {
            title = randomButtonTitle
        } while title == buttonTitle
        buttonTitle = title
    }
    
    // MARK: WKInterfaceController

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        buttonTitle = randomButtonTitle
        
        let url = Bundle.main.url(forResource: "Larry Owens - Interlude", withExtension: "mp3")!
        let asset = WKAudioFileAsset(url: url)
        player = WKAudioFilePlayer(playerItem: WKAudioFilePlayerItem(asset: asset))
        player.play()
    }

}
