//
//  StatisticsVC.swift
//  ActiveLaziness
//
//  Created by Ilya Kokorin on 25.09.2024.
//

import UIKit
import CoreData

class StatisticsVC: UIViewController {
  
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var arrayOfActivities = [ActivityLogItem]()

    @IBOutlet var firstStatLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        let mostTimeConsumingActivity = findMostTimeConsumingActivity()
        firstStatLabel.text = "Your most time consuming activity of all is \(mostTimeConsumingActivity ?? "none")"
    }
    
    func findMostTimeConsumingActivity() -> String? {
            guard !arrayOfActivities.isEmpty else { return "none" }
            let resultActivity = arrayOfActivities.max(by: { $0.activityDuration < $1.activityDuration })
            return resultActivity?.activityType
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
