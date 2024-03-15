//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 28/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation



class ViewController: UIViewController {

    var player:	AVAudioPlayer?
    var xylophoneLetter: String = "WWW"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func cButton(_ sender: UIButton) {
        print(sender)
        playSound(playSoundLetter: sender.currentTitle!)
        greeting(whoToGreet: "\(sender.currentTitle ?? "www")")
        sender.layer.opacity = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            sender.layer.opacity = 1
        }
    }
    
    func greeting(whoToGreet:String){
        print("Hello \(whoToGreet)")
    }

    func playSound(playSoundLetter:String) {
        guard let url = Bundle.main.url(forResource: playSoundLetter, withExtension: "wav") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
}

