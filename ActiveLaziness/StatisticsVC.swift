//
//  StatisticsVC.swift
//  ActiveLaziness
//
//  Created by Ilya Kokorin on 25.09.2024.
//

import UIKit

class StatisticsVC: UIViewController {
    
    var activitiesSample = [ActivityLogItem(activityType: "Swimming", activityDuration: 600, activityDate: Date()),                             ActivityLogItem(activityType: "Kissing", activityDuration: 1000, activityDate: Date() + 100000),
                            ActivityLogItem(activityType: "Swimming", activityDuration: 600, activityDate: Date() - 100000),
                            ActivityLogItem(activityType: "Kissing", activityDuration: 1000, activityDate: Date() + 200000),
                            ActivityLogItem(activityType: "Swimming", activityDuration: 600, activityDate: Date()),
                            ActivityLogItem(activityType: "Swimming", activityDuration: 1600, activityDate: Date())]

    @IBOutlet var firstStatLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mostTimeConsumingActivity = findMostTimeConsumingActivity()
        firstStatLabel.text = "Your most time consuming activity of all is \(mostTimeConsumingActivity!)"
    }
    
    func findMostTimeConsumingActivity() -> String? {
            guard !activitiesSample.isEmpty else { return nil }
            let resultActivity = activitiesSample.max(by: { $0.activityDuration < $1.activityDuration })
            return resultActivity?.activityType
        }
}
