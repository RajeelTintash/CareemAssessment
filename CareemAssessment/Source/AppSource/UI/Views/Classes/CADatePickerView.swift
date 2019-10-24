//
//  CADatePickerView.swift
//  CareemAssesment
//
//  Created by Rajeel Amjad on 22/10/2019.
//  Copyright © 2019 Rajeel Amjad. All rights reserved.
//

import UIKit



/// This is the DatePicker view
@IBDesignable class CADatePickerView: UIView {

    @IBOutlet weak var containerView            : UIView!
    @IBOutlet weak var datePicker               : UIDatePicker!
   
    // Toolbar callbacks to be implemented by parent view controller
    var cancelPressed                           : (()->())?
    var donePressed                             : ((Date)->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initNib()
    }
    
    /// Initializes the view from xib
    fileprivate func initNib() {
        let bundle = Bundle(for: CADatePickerView.self)
        bundle.loadNibNamed("CADatePickerView", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        datePicker.maximumDate = Date()
    }
    
    /// Toolbar cancel button pressed
    @IBAction func cancelButtonPressed() {
        cancelPressed?()
    }
    
    /// Toolbar done button pressed
    @IBAction func doneButtonPressed() {
        donePressed?(datePicker.date)
    }
}
