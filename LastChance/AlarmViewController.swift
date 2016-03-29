//
//  AlarmViewController.swift
//  LastChance
//
//  Created by Ben Chaimberg on 2/11/16.
//  Copyright © 2016 Ben Chaimberg. All rights reserved.
//

import UIKit

class AlarmViewController: UIViewController {

    var alarms = [Alarm]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let savedAlarms = loadAlarms() {
            alarms += savedAlarms
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    @IBAction func unwindToAlarmList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? AddAlarmViewController, alarm = sourceViewController.alarm {
            for index in 0...3 {
                let localNotification = UILocalNotification()
                let newAlarmTime = alarm.time.dateByAddingTimeInterval(15.0 * Double(index))
                localNotification.fireDate = newAlarmTime
                localNotification.repeatInterval = NSCalendarUnit.Minute
                print("lN.fD", localNotification.fireDate)
                localNotification.alertAction = "Dismiss"
                localNotification.alertTitle = "LastChance Alarm"
                localNotification.alertBody = "You haven't left yet and if you don't now you might be late!"
                localNotification.soundName = "Radiate.aiff"
                UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
            }
            alarms.append(alarm)
        }
        saveAlarms()
    }

    func saveAlarms() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(alarms, toFile: Alarm.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save meals...")
        }
    }
    func loadAlarms() -> [Alarm]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Alarm.ArchiveURL.path!) as? [Alarm]
    }

}
