//
//  ViewController.swift
//  SoundTest
//
//  Created by Ryunosuke Kirikihira on 2016/05/29.
//  Copyright © 2016年 Krimpedance. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    let soundIdRing:SystemSoundID = 1028
    var functionPointer: AudioServicesCompletionFunctionPointer!
    var soundCounter = 3

    override func viewDidLoad() {
        super.viewDidLoad()

        functionPointer = AudioServicesCompletionFunctionPointer(systemSoundID: soundIdRing, block: blockFunc, userData: nil)
    }

    func blockFunc(systemSoundID: SystemSoundID, userData: UnsafeMutablePointer<Void>) {
        soundCounter -= 1
        if soundCounter > 0 {
            AudioServicesPlaySystemSound(soundIdRing)
        } else {
            AudioServicesRemoveSystemSoundCompletion(soundIdRing)
        }
    }
}


/**
 *  Button actions ----------
 */
extension ViewController {
    @IBAction func playButtonTapped(sender: AnyObject) {
        soundCounter = 2
        AudioServicesRemoveSystemSoundCompletion(soundIdRing)
        AudioServicesAddSystemSoundCompletion(soundIdRing, CFRunLoopGetMain(), kCFRunLoopCommonModes, AudioServicesCompletionFunctionPointer.completionHandler(), nil)
        AudioServicesPlaySystemSound(soundIdRing)
    }

    @IBAction func changeButtonTapped(sender: AnyObject) {
//        let actionSheet = UIAlertController(title: "Change", message: "", preferredStyle: .ActionSheet)

        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord, withOptions: .AllowBluetooth)
            try AVAudioSession.sharedInstance().setMode(AVAudioSessionModeVoiceChat)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("AVAudioSession error")
        }
    }
}
