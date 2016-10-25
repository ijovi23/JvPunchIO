//
//  PRHomeTableHeader.swift
//  JvPunchIO-Recorder
//
//  Created by Jovi Du on 24/10/2016.
//  Copyright © 2016 org.Jovistudio. All rights reserved.
//

import UIKit

class PRHomeTableHeader: UIView {

    @IBOutlet weak var labDate: UILabel!
    
    @IBOutlet weak var labTotal: UILabel!

    var recordGroup : PRRecordGroup? {
        didSet {
            labDate.text = recordGroup?.date
            setupLabTotal()
        }
    }
    
    
    func setupLabTotal() {
        labTotal.text = "0hrs"
    }
}
