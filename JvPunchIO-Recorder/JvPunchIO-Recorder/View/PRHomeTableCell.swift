//
//  PRHomeTableCell.swift
//  JvPunchIO-Recorder
//
//  Created by Jovi Du on 21/10/2016.
//  Copyright © 2016 org.Jovistudio. All rights reserved.
//

import UIKit

class PRHomeTableCell: UITableViewCell {
    
    @IBOutlet weak var labTime: UILabel!
    @IBOutlet weak var labDate: UILabel!
    
    var record : Date? {
        didSet {
            labTime.text = self.record?.pr_string(withFormat: "HH:mm")
            labDate.text = self.record?.pr_dateString()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
