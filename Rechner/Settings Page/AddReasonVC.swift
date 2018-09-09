//
//  AddReasonVC.swift
//  Rechner
//
//  Created by Aliagha Seyidov on 9/6/18.
//  Copyright © 2018 Aliagha Seyidov. All rights reserved.
//

import UIKit
import Locksmith
import NotificationBannerSwift

class AddReasonVC: GeneralViewController {
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var reasonTextField: UITextField!
    @IBOutlet weak var inOutSegment: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        addButton.layer.cornerRadius = Constants.Style.cornerRadius
    }
    
    
    @IBAction func addButtonClick(_ sender: Any) {
        view.endEditing(true)
        
        if validateText(reasonTextField) {
            let isOut = Bool(truncating: inOutSegment.selectedSegmentIndex as NSNumber)
            saveReason(reasonTextField.text ?? "", isOut: isOut)
            
        } else {
            showErrorBanner()
        }
    }
    
}
