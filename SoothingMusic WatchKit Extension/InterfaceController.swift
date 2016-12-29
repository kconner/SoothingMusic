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

    private var extensionDelegate: ExtensionDelegate {
        return WKExtension.shared().delegate as! ExtensionDelegate
    }

    private var buttonTitle = "" {
        didSet {
            pauseButton.setTitle(buttonTitle)
        }
    }

    // MARK: Helpers

    @IBAction private func didTapPauseButton() {
        if extensionDelegate.player.isPlaying {
            extensionDelegate.player.pause()
        } else {
            extensionDelegate.player.play()
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
    }

}
