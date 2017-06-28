//
//  ViewController.swift
//  AeroTimer
//
//  Created by Milosz on 25/06/2017.
//  Copyright © 2017 Milosz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var toggleButton: UIButton!
    @IBOutlet weak var currentStepLabel: UILabel!
    @IBOutlet weak var nextStepLabel: UILabel!

    
    var minutes = 0
    var seconds = -5
    var timer = Timer()
    var timerRunning = false
    var times: [String] = ["0:00", "0:30", "0:40", "2:00", "2:15"]
    var steps: [String] = ["Bloom", "Fill", "Brew", "Push", "Done"]
    var step = -1;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        timerLabel.text = "0:-5"
        currentStepLabel.text = "Get ready"
        nextStepLabel.text = steps[0]
    }
    
    //MARK: Actions


    @IBAction func toggleTimer(_ sender: UIButton) {
        if !timerRunning {
            toggleButton.setTitle("Stop", for: .normal)
            timerRunning = true
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        } else {
            toggleButton.setTitle("Start", for: .normal)
            timerRunning = false
            timer.invalidate()
        }
    }

    
    @IBAction func resetTimer(_ sender: UIButton) {
        timerLabel.text = "0:-5"
        toggleButton.setTitle("Start", for: .normal)
        timer.invalidate()
        minutes = 0
        seconds = -5
        timerRunning = false
        toggleButton.isEnabled = true
        currentStepLabel.text = "Get ready"
        nextStepLabel.text = steps[0]
        step = -1
    }
    
    func updateTimer() {
        seconds += 1
        if seconds == 60 {
            minutes += 1
            seconds = 0
        }
        let timeString = String(format: "%d:%02d", arguments: [minutes, seconds])
        timerLabel.text = timeString
        if times.contains(timeString) {
            nextStep()
        }
    }
    
    func nextStep() {
        step += 1
        currentStepLabel.text = steps[step]
        if step == steps.count - 1 {
            nextStepLabel.text = ""
            timerRunning = false
            timer.invalidate()
            toggleButton.isEnabled = false
            
        } else {
            nextStepLabel.text = steps[step + 1]
        }
    }
}

