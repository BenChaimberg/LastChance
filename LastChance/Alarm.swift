//
//  Alarm.swift
//  LastChance
//
//  Created by Ben Chaimberg on 2/12/16.
//  Copyright © 2016 Ben Chaimberg. All rights reserved.
//

import UIKit

class Alarm: NSObject {
    
    // MARK: Properties
    var time: NSDate
    var location: AnyObject?

    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("alarms")
    
    // MARK: Types
    struct PropertyKey {
        static let timeKey = "time"
        static let locationKey = "location"
    }
    
    // MARK: Initialization
    init?(time: NSDate, location: AnyObject?) {
        self.time = time
        self.location = location
        super.init()
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(time, forKey: PropertyKey.timeKey)
        aCoder.encodeObject(location, forKey: PropertyKey.locationKey)
    }

    required convenience init?(coder aDecoder: NSCoder) {
        let time = aDecoder.decodeObjectForKey(PropertyKey.timeKey) as! NSDate
        let location = aDecoder.decodeObjectForKey(PropertyKey.locationKey)
        // Must call designated initilizer.
        self.init(time: time, location: location)
    }
    
}
