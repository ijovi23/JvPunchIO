//
//  Date-Extension.swift
//  JvPunchIO-Recorder
//
//  Created by Jovi Du on 24/10/2016.
//  Copyright © 2016 org.Jovistudio. All rights reserved.
//

import Foundation

extension Date {
    func pr_string(withFormat format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func pr_dateString() -> String {
        return pr_string(withFormat: "yyyy-MM-dd")
    }
    
    func pr_timeString() -> String {
        return pr_string(withFormat: "HH:mm:ss")
    }
}
