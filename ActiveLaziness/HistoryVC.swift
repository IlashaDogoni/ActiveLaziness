//
//  ActivitiesHistoryVC.swift
//  ActiveLaziness
//
//  Created by Ilya Kokorin on 25.09.2024.
//

import UIKit
import CoreData

class HistoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var arrayOfActivities = [ActivityLogItem]()
    
    
    @IBOutlet var activitiesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        activitiesTableView.delegate = self
        activitiesTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfActivities.count
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
                arrayOfActivities.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    
    func cellTextFormatter(indexPath: IndexPath) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MMM/yy"
        
        let activityTime = arrayOfActivities[indexPath.row].activityDuration
        let hours = arrayOfActivities[indexPath.row].activityDuration / 3600
        let minutes = (activityTime % 3600) / 60
        let seconds = activityTime % 60
        
        let timeToShow = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        let dateToShow = formatter.string(from: arrayOfActivities[indexPath.row].activityDate!)
        let preparedText = "\(dateToShow), \(timeToShow), \(arrayOfActivities[indexPath.row].activityType ?? "none")"
        return preparedText
    }
    
    //MARK: Core Data
    func loadItems() {
        let request: NSFetchRequest<ActivityLogItem> = ActivityLogItem.fetchRequest()
        do{
            arrayOfActivities = try context.fetch(request)
        } catch {
            print("Error fetching context \(error)")
        }
    }
}
