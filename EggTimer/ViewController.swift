//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 12]

    var hardness = ""
    var cookingTime = 0
    var elapsed = 0
    
    var player: AVAudioPlayer!
    var timer = Timer()

    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        
        hardness = sender.currentTitle!
        cookingTime = eggTimes[hardness]!

        elapsed = 0

        timer = Timer.scheduledTimer(timeInterval: 1.0,
                             target: self,
                             selector: #selector(updateTimer),
                             userInfo: nil,
                             repeats: true
        )

    }
    
    @objc func updateTimer() {
        
        if elapsed < cookingTime {
            mainLabel.text = "\(cookingTime - elapsed) seconds remaining"
            progressBar.progress = Float(elapsed) / Float(cookingTime)
            elapsed += 1
        }
        else {
            mainLabel.text = "Your \(hardness) egg is ready!"
            progressBar.progress = 1.0
            timer.invalidate()
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
                        player = try! AVAudioPlayer(contentsOf: url!)
                        player.play()
        }
        
    }
}
