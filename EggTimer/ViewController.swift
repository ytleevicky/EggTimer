import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var audioPlayer : AVPlayer!
    
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer();
    let eggTime = ["Soft": 300, "Medium": 420, "Hard": 720]

    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        let hardness = sender.currentTitle! // Soft, Medium, Hard
        totalTime = eggTime[hardness]!
        
        progressBar.progress = 0
        secondsPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateCounter() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            let percentageProgress = Float(secondsPassed) / Float(totalTime)
            progressBar.progress = percentageProgress
        
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            playAlarmSound()
            
        }
    }
    
    func playAlarmSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        audioPlayer = AVPlayer(url: url!)
        audioPlayer?.play()
    }
    
}
