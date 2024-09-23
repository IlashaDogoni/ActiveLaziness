//
//  ViewController.swift
//  ActiveLaziness
//
//  Created by Ilya Kokorin on 23.09.2024.
//

import UIKit

class MainVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var activityPicker: UIPickerView!
    
    @IBOutlet var playButton: UIButton!
    @IBOutlet var pauseButton: UIButton!
    @IBOutlet var stopButton: UIButton!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var typeOfActivityLabel: UILabel!
    @IBOutlet var timerLabel: UILabel!
    
    var timer = Timer()
    
    var activityTime = 0
    
    var pickedActivity: String = "Swimming"
    
    var activities = ["Swimming", "Reading", "Learning", "Scrolling reels"]
    
    var timeToSave = 0
    
    var arrayOfActivities = [ActivityLogItem]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityPicker.delegate = self
        self.activityPicker.dataSource = self
        updateTimerLabel()
        typeOfActivityLabel.text = ""
    }

    //BUTTONS STUFF
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        let newActivityInstance = ActivityLogItem(activityType: pickedActivity, activityDuration: timeToSave, activityDate: Date())
        arrayOfActivities.append(newActivityInstance)
        typeOfActivityLabel.text = ""
        updateTimerLabel()
    }
    
    @IBAction func addActivityButtonTapped(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Activity", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            if textField.text != nil && textField.text != "" {
                let newActivity = textField.text!
                self.activities.append(newActivity)
                print(self.activities)
                self.activityPicker.reloadAllComponents()
            }
        }
        
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Type a new activity"
            textField = alertTextfield
        }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
    }
    
    @IBAction func platButtonTapped(_ sender: UIButton) {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        typeOfActivityLabel.text = "of \(pickedActivity)"
    }
    
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        timer.invalidate()
    }
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        timer.invalidate()
        timeToSave = activityTime
        activityTime = 0
    }
    
    //PICKER STUFF
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        activities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return activities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedActivity = activities[row]
    }
    
    //TIMER STUFF
    @objc func fireTimer(){
        activityTime += 1
        updateTimerLabel()
    }
    
    func updateTimerLabel() {
            let hours = activityTime / 3600
            let minutes = (activityTime % 3600) / 60
            let seconds = activityTime % 60
            
            timerLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

