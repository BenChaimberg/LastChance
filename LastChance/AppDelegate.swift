//
//  AppDelegate.swift
//  LastChance
//
//  Created by Ben Chaimberg on 2/5/16.
//  Copyright © 2016 Ben Chaimberg. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var alarms = [Alarm]()
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes:[.Alert,.Sound], categories: nil))
        return true
    }

    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        if notificationSettings != UIUserNotificationSettings(forTypes:[.Alert,.Sound], categories: nil) {
            let alertController = UIAlertController.init(title:"Enable Notifications", message:"LastChance is unable to function as an alarm if it is unable to set notifications. Please enable notifications for LastChance in Settings!", preferredStyle:.Alert)
            let toSettings = UIAlertAction.init(title: "Go to Settings", style: .Default, handler: { (UIAlertAction) -> Void in
                let settingsString = UIApplicationOpenSettingsURLString
                let settingsURL = NSURL.init(string: settingsString)
                application.openURL(settingsURL!)
            })
            let cancelToSettings = UIAlertAction.init(title: "Cancel", style: .Cancel, handler: nil)
            alertController.addAction(toSettings)
            alertController.addAction(cancelToSettings)
            alertController.preferredAction = toSettings
            let navigationController = application.windows[0].rootViewController as! UINavigationController
            let activeViewController = navigationController.visibleViewController!
            activeViewController.presentViewController(alertController, animated: true, completion: nil)
        }
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

        if let savedAlarms = loadAlarms() {
            print(alarms)
            alarms = savedAlarms
            print(alarms)
        }
        let scheduledNotifications = UIApplication.sharedApplication().scheduledLocalNotifications
        for alarm in alarms {
            if alarm.time.compare(NSDate()) == NSComparisonResult.OrderedAscending {
                for scheduledNotification in scheduledNotifications! {
                    if scheduledNotification.fireDate?.timeIntervalSinceDate(alarm.time) < 60.0 {
                        application.cancelLocalNotification(scheduledNotification)
                    }
                }
                alarms.removeAtIndex(alarms.indexOf(alarm)!)
                saveAlarms()
                continue
            }
        }
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func saveAlarms() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(alarms, toFile: Alarm.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save meals...")
        }
    }
    func loadAlarms() -> [Alarm]? {
        print("loadAlarms")
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Alarm.ArchiveURL.path!) as? [Alarm]
    }

}

