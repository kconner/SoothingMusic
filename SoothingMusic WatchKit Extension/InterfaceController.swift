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

    @IBOutlet private var volumeSlider: WKInterfaceSlider!
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

    @IBAction func volumeSliderValueChanged(_ value: Float) {
        UserDefaults.standard.set(value, forKey: "volume")
        extensionDelegate.updateVolume()
    }
    
    @IBAction private func didTapPauseButton() {
        if let player = extensionDelegate.player {
            if player.isPlaying {
                player.pause()
                volumeSlider.setEnabled(false)
            } else {
                player.play()
                volumeSlider.setEnabled(true)
            }
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

        volumeSlider.setValue(UserDefaults.standard.float(forKey: "volume"))
        buttonTitle = Titles.random
    }

}
