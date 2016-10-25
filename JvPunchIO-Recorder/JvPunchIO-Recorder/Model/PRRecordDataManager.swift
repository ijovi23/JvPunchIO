//
//  PRRecordDataManager.swift
//  JvPunchIO-Recorder
//
//  Created by Jovi Du on 24/10/2016.
//  Copyright © 2016 org.Jovistudio. All rights reserved.
//

import UIKit
import FileKit

class PRRecordDataManager: NSObject {
    var data : [PRRecordGroup] = []
    
    static let sharedManager = PRRecordDataManager()
    
    func addRecord(_ record: Date) {
        let recordDate = record.pr_dateString()
        var (group, _) = getGroup(withDate: recordDate)
        if group != nil {
            group?.records.append(record)
            group?.records.sort(by: >)
        } else {
            group = PRRecordGroup(withDate: recordDate, records: [record])
            data.append(group!)
            data.sort(by: { (group1, group2) -> Bool in
                group1.date > group2.date
            })
        }
        saveData(callback: nil)
    }
    
    func removeRecord(_ record: Date) {
        let recordDate = record.pr_dateString()
        let (group, groupIndex) = getGroup(withDate: recordDate)
        if group == nil {
            return
        }
        
        var removingIdx = -1
        
        for (index, aDate) in group!.records.enumerated() {
            if aDate == record {
                removingIdx = index
                break
            }
        }
        
        if removingIdx >= 0 {
            group!.records.remove(at: removingIdx)
        }
        
        if group!.records.count <= 0 {
            data.remove(at: groupIndex!)
        }
        
        saveData(callback: nil)
    }
    
    func clear() {
        data = []
        saveData(callback: nil)
    }
    
    func getGroup(withDate date: String) -> (group: PRRecordGroup?, index: Int?) {
        for (idx, aGroup) in data.enumerated() {
            if aGroup.date == date {
                return (aGroup, idx)
            }
        }
        return (nil, nil)
    }
    
    func loadData(callback: ((NSError?) -> Void)?) {
//        let recList = [Date(), Date.init(timeIntervalSinceNow: 9910)]
//        data.append(PRRecordGroup(withDate: "2016-10-24", records: recList))
//        callback?(nil)
        
        data.removeAll()
        if Path(archFilePath()).exists {
            let unarchiveDate = NSKeyedUnarchiver.unarchiveObject(withFile: archFilePath()) as! [PRRecordGroup]
            data.append(contentsOf: unarchiveDate)
        }
    }
    
    func saveData(callback: ((NSError?) -> Void)?) {
        if NSKeyedArchiver.archiveRootObject(data, toFile: archFilePath()) {
            print("- Archive Successfully -")
            callback?(nil)
        } else {
            callback?(NSError(domain: "Archive Failed", code: -100, userInfo: nil))
        }
    }
    
    
    func archFilePath() -> String {
        let dir : String? = Path.userDocuments.rawValue
        let filePath : String
        if dir != nil {
            filePath = dir!.appending("/records.arch")
        } else {
            filePath = ""
        }
        return filePath
    }
}
