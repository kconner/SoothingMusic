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

final class InterfaceController: WKInterfaceController, WKCrownDelegate {

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
        extensionDelegate.volume = value
        extensionDelegate.saveVolume()
    }
    
    @IBAction private func didTapPauseButton() {
        if let player = extensionDelegate.player {
            if player.isPlaying {
                player.pause()
            } else {
                player.play()
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

        crownSequencer.delegate = self
        crownSequencer.focus()

        volumeSlider.setValue(extensionDelegate.volume)
        buttonTitle = Titles.random
    }

    // MARK: WKCrownDelegate

    func crownDidRotate(_ crownSequencer: WKCrownSequencer?, rotationalDelta: Double) {
        let volume = max(0.0, min(1.0, extensionDelegate.volume + Float(rotationalDelta)))
        volumeSlider.setValue(volume)
        extensionDelegate.volume = volume
    }

    func crownDidBecomeIdle(_ crownSequencer: WKCrownSequencer?) {
        extensionDelegate.saveVolume()
    }

}
