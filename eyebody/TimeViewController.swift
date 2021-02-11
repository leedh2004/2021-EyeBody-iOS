//
//  TimeViewController.swift
//  eyebody
//
//  Created by 이도현 on 2021/01/20.
//

import UIKit

class TimeViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timeButton: UIButton!
    
    var timer: Timer? = nil
    var isTimerOn = false
    var timeWhenGoBackground: Date?
    var timeSecond = 0 {
        willSet(newValue) {
            var hours = String(newValue / 3600)
            var minutes = String(newValue / 60)
            var seconds = String(newValue % 60)
            if hours.count == 1 { hours = "0"+hours }
            if minutes.count == 1 { minutes = "0"+minutes }
            if seconds.count == 1 { seconds = "0"+seconds }
            timerLabel.text = "\(hours):\(minutes):\(seconds)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc func appMovedToBackground() {
        print("App moved to background!")
        if isTimerOn {
            timeWhenGoBackground = Date()
            print("Save")
        }
    }
    
    @objc func appMovedToForeground() {
        print("App moved to foreground")
        if let backTime = timeWhenGoBackground {
            let elapsed = Date().timeIntervalSince(backTime)
            let duration = Int(elapsed)
            timeSecond += duration
            timeWhenGoBackground = nil
            print("DURATION: \(duration)")
        }
    }
    
    @IBAction func timeBtnClicked(_ sender: Any) {
        if isTimerOn {
            timer?.invalidate()
            timeButton.setTitle("START", for: .normal)
        } else {
            self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                self.timeSecond += 1
                print("\(self.timeSecond)")
            }
            RunLoop.current.add(self.timer!, forMode: .common)
            timeButton.setTitle("STOP", for: .normal)
        }
        isTimerOn = !isTimerOn
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
