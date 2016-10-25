//
//  PRModifyRecordView.swift
//  JvPunchIO-Recorder
//
//  Created by Jovi Du on 25/10/2016.
//  Copyright © 2016 org.Jovistudio. All rights reserved.
//

import UIKit

protocol PRModifyRecordViewDelegate: class {
    func modifyRecordView(_ modifyRecordView: PRModifyRecordView, didModify date: Date)
}

class PRModifyRecordView: UIView {

    weak var delegate: PRModifyRecordViewDelegate?
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var btnClose: UIButton!
    
    @IBOutlet weak var picker: UIDatePicker!
    
    @IBOutlet weak var btnModify: UIButton!
    
    func show(withDate date: Date) {
        
        if superview == nil {
            UIApplication.shared.keyWindow?.addSubview(self)
        }
        
        picker.setDate(date, animated: false)
        
        let sWidth = bounds.size.width
        let sHeight = bounds.size.height
        
        self.mainView.center = CGPoint(x: (sWidth / 2), y: (sHeight + mainView.bounds.height / 2))
        self.alpha = 0
        
        UIView.animate(withDuration: 0.2) {
            self.mainView.center = CGPoint(x: (sWidth / 2), y: (sHeight / 2))
            self.alpha = 1
        }
    }
    
    func hide() {
        
        let sWidth = bounds.size.width
        let sHeight = bounds.size.height
        
        UIView.animate(withDuration: 0.2, animations: {
            self.mainView.center = CGPoint(x: (sWidth / 2), y: (sHeight + self.mainView.bounds.height / 2))
            self.alpha = 0
            })
        { (finished) in
            self.removeFromSuperview()
        }
    }
    
    @IBAction func btnClosePressed(_ sender: UIButton) {
        hide()
    }
    
    @IBAction func btnModifyPressed(_ sender: UIButton) {
        delegate?.modifyRecordView(self, didModify: picker.date)
        hide()
    }

}
