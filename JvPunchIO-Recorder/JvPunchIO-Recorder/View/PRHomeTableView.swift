//
//  PRHomeTableView.swift
//  JvPunchIO-Recorder
//
//  Created by Jovi Du on 21/10/2016.
//  Copyright © 2016 org.Jovistudio. All rights reserved.
//

import UIKit

let kRecordCellID = "RecordCell"

class PRHomeTableView: UITableView, UITableViewDataSource, UITableViewDelegate {

    var dataManager = PRRecordDataManager.sharedManager
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        config()
        refresh()
    }
    
    private func config() {
        tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 49))
        backgroundColor = UIColor.init(white: 0.9, alpha: 1)
        
        dataSource = self
        delegate = self
        
        register(UINib.init(nibName: "PRHomeTableCell", bundle: nil), forCellReuseIdentifier: kRecordCellID)
    }
    
    func refresh() {
        dataManager.loadData { (err) in
            if err != nil {
                print(err)
            } else {
                self.reloadData()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataManager.data.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let group = dataManager.data[section]
        if group.records.count <= 0 {
            return nil
        }
        
        let view = Bundle.main.loadNibNamed("PRHomeTableHeader", owner: nil, options: nil)?.first as! PRHomeTableHeader
        
        view.recordGroup = group
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let group = dataManager.data[section]
        if group.records.count <= 0 {
            return 0
        }
        
        return 38
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.data[section].records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kRecordCellID, for: indexPath) as! PRHomeTableCell
        
        let group = dataManager.data[indexPath.section]
        let record = group.records[indexPath.row]
        
        cell.record = record
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let group = dataManager.data[indexPath.section]
            let record = group.records[indexPath.row]
            dataManager.removeRecord(record)
            reloadData()
        }
    }
}
