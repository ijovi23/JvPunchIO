//
//  PRHomeViewController.swift
//  JvPunchIO-Recorder
//
//  Created by Jovi Du on 21/10/2016.
//  Copyright © 2016 org.Jovistudio. All rights reserved.
//

import UIKit

class PRHomeViewController: UIViewController, PRAddRecordViewDelegate {

    @IBOutlet weak var table: PRHomeTableView!
    
    @IBOutlet weak var bottomBar: UIView!
    
    @IBOutlet weak var btnClear: UIBarButtonItem!
    
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnPunch: UIButton!
    
    var addView: PRAddRecordView?
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(recordDataChanged), name: kRecordDataSavedNotification, object: nil)
        
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setupUI() {
        addView = Bundle.main.loadNibNamed("PRAddRecordView", owner: nil, options: nil)?.first as! PRAddRecordView?
        addView?.delegate = self
        
        table.refresh()
    }
    
    @IBAction func btnPunchPressed(_ sender: UIButton) {
        self.table.dataManager.addRecord(Date())
        self.table.reloadData()
    }
    
    @IBAction func btnAddPressed(_ sender: UIButton) {
        addView?.show()
    }

    @IBAction func btnClearPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Clear all records?", message: nil, preferredStyle: .alert)
        
        let actCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(actCancel)
        
        let actClear = UIAlertAction(title: "Clear", style: .destructive) { (action) in
            self.table.dataManager.clear()
            self.table.reloadData()
        }
        alert.addAction(actClear)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func addRecordView(_ addRecordView: PRAddRecordView, didAdd date: Date) {
        if addRecordView == addView {
            self.table.dataManager.addRecord(date)
            self.table.reloadData()
        }
    }
    
    
    func recordDataChanged() {
        let totalDur = PRRecordDataManager.sharedManager.calcDuration()
        let totalDurString = String(format: "%.2lf", totalDur / 3600.0)
        title = "\(totalDurString) hrs"
    }
}
