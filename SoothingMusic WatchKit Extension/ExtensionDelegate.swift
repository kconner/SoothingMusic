//
//  ExtensionDelegate.swift
//  SoothingMusic WatchKit Extension
//
//  Created by Kevin Conner on 12/28/16.
//  Copyright © 2016 Kevin Conner. All rights reserved.
//

import WatchKit
import AVFoundation

final class ExtensionDelegate: NSObject, WKExtensionDelegate {

    private var engine: AVAudioEngine?
    private(set) var player: AVAudioPlayerNode?

    private var didSetUp = false

    func updateVolume() {
        player?.volume = UserDefaults.standard.float(forKey: "volume")
    }

    // MARK: Helpers

    private func setUpOnce() {
        guard !didSetUp else {
            return
        }

        didSetUp = true

        let audioFile: AVAudioFile

        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)

            let engine = AVAudioEngine()
            self.engine = engine

            let player = AVAudioPlayerNode()
            self.player = player
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

        updateVolume()
        player?.scheduleFile(audioFile, at: nil, completionHandler: nil)
        player?.play()
    }

    // MARK: WKExtensionDelegate

    func applicationDidFinishLaunching() {
        UserDefaults.standard.register(defaults: ["volume" : Float(0.5)])
    }

    func applicationDidBecomeActive() {
        setUpOnce()
        
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
        for task in backgroundTasks {
            // Use a switch statement to check the task type
            switch task {
            case let backgroundTask as WKApplicationRefreshBackgroundTask:
                // Be sure to complete the background task once you’re done.
                backgroundTask.setTaskCompleted()
            case let snapshotTask as WKSnapshotRefreshBackgroundTask:
                // Snapshot tasks have a unique completion call, make sure to set your expiration date
                snapshotTask.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: Date.distantFuture, userInfo: nil)
            case let connectivityTask as WKWatchConnectivityRefreshBackgroundTask:
                // Be sure to complete the connectivity task once you’re done.
                connectivityTask.setTaskCompleted()
            case let urlSessionTask as WKURLSessionRefreshBackgroundTask:
                // Be sure to complete the URL session task once you’re done.
                urlSessionTask.setTaskCompleted()
            default:
                // make sure to complete unhandled task types
                task.setTaskCompleted()
            }
        }
    }

}
