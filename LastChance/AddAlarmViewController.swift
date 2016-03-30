//
//  AddAlarmViewController.swift
//  LastChance
//
//  Created by Ben Chaimberg on 2/12/16.
//  Copyright © 2016 Ben Chaimberg. All rights reserved.
//

import UIKit

class AddAlarmViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var alarmPicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var alarm: Alarm?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            print("second")
            alarm = Alarm(time: alarmPicker.date, location: nil)
        }
    }

    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "save" {
            let ringerAlertController = UIAlertController.init(title: "Ringer Volume Check", message: "Please make sure your device is not in silent mode, headphones/speakers are unplugged, and the ringer volume is at its maximum so the alarm will be at its most effective!", preferredStyle: .Alert)
            let dismissAction = UIAlertAction.init(title: "Continue", style: .Default, handler: { (UIAlertAction) -> Void in
                self.navigationController?.popToRootViewControllerAnimated(true)
                self.performSegueWithIdentifier("ringerDismiss", sender: sender)
            })
            ringerAlertController.addAction(dismissAction)
            ringerAlertController.preferredAction = dismissAction
            let navigationController = UIApplication.sharedApplication().windows[0].rootViewController as! UINavigationController
            let activeViewController = navigationController.visibleViewController!
            activeViewController.presentViewController(ringerAlertController, animated: true, completion: nil)
            return false
        } else {
            return true
        }
    }

    @IBAction func cancelButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    

}
