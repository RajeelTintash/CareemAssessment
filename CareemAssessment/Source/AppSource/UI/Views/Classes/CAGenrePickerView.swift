//
//  CAGenrePickerView.swift
//  CareemAssesment
//
//  Created by Rajeel Amjad on 22/10/2019.
//  Copyright © 2019 Rajeel Amjad. All rights reserved.
//

import UIKit

/// This is the genre picker view
@IBDesignable class CAGenrePickerView: UIView {
    @IBOutlet weak var containerView            : UIView!
    @IBOutlet weak var genrePicker              : UIPickerView!
    private(set) var genres                     : [Genre] = []
    fileprivate var selectedRow                 = 0
    
    // Callbacks to be impelmented by parent view controller
    var cancelPressed                           : (()->())?
    var donePressed                             : ((Int)->())?
     
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
         let bundle = Bundle(for: CAGenrePickerView.self)
         bundle.loadNibNamed("CAGenrePickerView", owner: self, options: nil)
         addSubview(containerView)
         containerView.frame = bounds
         containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    /// Toolbar cancel button pressed
    @IBAction func cancelButtonPressed() {
         cancelPressed?()
    }
    
    /// Toolbar Done button pressed
    @IBAction func doneButtonPressed() {
        donePressed?(selectedRow)
    }
}

extension CAGenrePickerView {
    /// Sets the genres data source for picker
    /// - Parameter genres: list of genres
    func setGenres(_ genres: [Genre]) {
        self.genres = genres
    }
}

//MARK:- UIPickerView DataSource
extension CAGenrePickerView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genres.count
    }
}

//MARK:- UIPickerView Delegate
extension CAGenrePickerView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let genre = genres[row]
        return genre.name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
    }
}

