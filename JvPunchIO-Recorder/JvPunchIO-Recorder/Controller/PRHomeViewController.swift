//
//  PRHomeViewController.swift
//  JvPunchIO-Recorder
//
//  Created by Jovi Du on 21/10/2016.
//  Copyright © 2016 org.Jovistudio. All rights reserved.
//

import UIKit

class PRHomeViewController: UIViewController {

    @IBOutlet weak var table: PRHomeTableView!
    
    @IBOutlet weak var bottomBar: UIView!
    
    @IBOutlet weak var btnClear: UIBarButtonItem!
    
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnPunch: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func btnPunchPressed(_ sender: UIButton) {
        self.table.dataManager.addRecord(Date())
        self.table.reloadData()
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
}
