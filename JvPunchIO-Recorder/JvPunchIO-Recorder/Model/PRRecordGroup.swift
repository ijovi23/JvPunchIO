//
//  PRRecordModel.swift
//  JvPunchIO-Recorder
//
//  Created by Jovi Du on 21/10/2016.
//  Copyright © 2016 org.Jovistudio. All rights reserved.
//

import UIKit

class PRRecordGroup: NSObject, NSCoding {
    
    var date : String = "2000-00-00"
    
    var records : [Date] = []
    
    init(withDate date: String, records: [Date]) {
        self.date = date
        self.records = records
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(date, forKey: "date")
        aCoder.encode(records, forKey: "records")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.date = aDecoder.decodeObject(forKey: "date") as! String
        self.records = aDecoder.decodeObject(forKey: "records") as! [Date]
    }
    
    func calcDuration() -> TimeInterval {
        var dur : TimeInterval = 0
        
        if records.count >= 2 {
            dur = records.first!.timeIntervalSince(records.last!)
        }
        
        return dur
    }
}
