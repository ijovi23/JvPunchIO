//
//  PRHomeTableView.swift
//  JvPunchIO-Recorder
//
//  Created by Jovi Du on 21/10/2016.
//  Copyright © 2016 org.Jovistudio. All rights reserved.
//

import UIKit

class PRHomeTableView: UITableView, UITableViewDataSource, UITableViewDelegate {

    override func awakeFromNib() {
        super.awakeFromNib();
        
        
    }
    
    func config() {
        dataSource = self;
        delegate = self;
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 0;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("", forIndexPath: indexPath);
        
        return cell;
    }

}
