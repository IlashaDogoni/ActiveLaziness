//
//  ActivitiesHistoryVC.swift
//  ActiveLaziness
//
//  Created by Ilya Kokorin on 25.09.2024.
//

import UIKit

class HistoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var activitiesSample = [ActivityLogItem(activityType: "Swimming", activityDuration: 600, activityDate: Date()),                             ActivityLogItem(activityType: "Kissing", activityDuration: 1000, activityDate: Date() + 100000),
                            ActivityLogItem(activityType: "Swimming", activityDuration: 600, activityDate: Date() - 100000),
                            ActivityLogItem(activityType: "Kissing", activityDuration: 1000, activityDate: Date() + 200000),
                            ActivityLogItem(activityType: "Swimming", activityDuration: 600, activityDate: Date()),
                            ActivityLogItem(activityType: "Swimming", activityDuration: 1600, activityDate: Date())]
    
    @IBOutlet var activitiesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activitiesTableView.delegate = self
        activitiesTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activitiesSample.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else {
            return UITableViewCell()
        }
        cell.textLabel?.text = cellTextFormatter(indexPath: indexPath)
        return  cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                activitiesSample.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    
    func cellTextFormatter(indexPath: IndexPath) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MMM/yyyy"
        
        let activityTime = activitiesSample[indexPath.row].activityDuration
        let hours = activitiesSample[indexPath.row].activityDuration / 3600
        let minutes = (activityTime % 3600) / 60
        let seconds = activityTime % 60
        
        let timeToShow = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        let dateToShow = formatter.string(from: activitiesSample[indexPath.row].activityDate)
        let preparedText = "\(dateToShow), \(timeToShow), \(activitiesSample[indexPath.row].activityType)"
        return preparedText
    }
    
    
}
