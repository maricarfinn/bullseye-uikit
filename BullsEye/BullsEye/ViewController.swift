//
//  ViewController.swift
//  BullsEye
//
//  Created by Maricar Finn on 11/06/2020.
//  Copyright © 2020 Maricar Finn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue: Int = 0
    var targetValue: Int = 0
    var score = 0
    var currentRound = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var randomNumberLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundCount: UILabel!

    override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
      let roundedValue = slider.value.rounded()
      currentValue = Int(roundedValue)
      startOver()
    
      let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
      slider.setThumbImage(thumbImageNormal, for: .normal)
      
      let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
      slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
      
      let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
      
      
      let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
      let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
      slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
      
      let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
      let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
      slider.setMaximumTrackImage(trackRightResizable, for: .normal)
      
      
    }

    @IBAction func showAlert() {
        
        let difference = abs(currentValue - targetValue)
        var points = 100 - difference
        
        score += points
        
        let title: String
        
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference == 1 {
            title = "Just 1 point off"
            points += 50
        } else if difference < 5 {
            title = "You almost had it!"
        } else if difference < 10 {
            title = "That's still pretty good"
        } else {
            title = "Not even close"
        }
        
        let message = "You scored \(points) points"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default, handler: {
            action in
            self.startNewRound()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)
    }
    
    
    func startNewRound() {
        currentRound += 1
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        randomNumber()
    }
    
    func randomNumber() {
        randomNumberLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundCount.text = String(currentRound)
    }
    
    @IBAction func startOver() {
        score = 0
        currentRound = 0
        startNewRound()
    }

}

