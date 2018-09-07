//
//  SaveReasonVC.swift
//  Rechner
//
//  Created by Aliagha Seyidov on 9/7/18.
//  Copyright © 2018 Aliagha Seyidov. All rights reserved.
//

import UIKit


class SaveReasonVC: UIViewController {
    
    var reasonKey : String?
    var reasonData : [String : Any]?
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var reasonTextField: UITextField!
    @IBOutlet weak var inOutSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.layer.cornerRadius = Constants.Style.cornerRadius
        setDataForEdit()
    }
    
    private func setDataForEdit() {
        reasonTextField.text = reasonData![Constants.Dictionaries.ReasonKeys.reason] as? String
        
        switch reasonKey {
        case Constants.Properties.moneyTransactionReasonKeyForIncome:
            inOutSegment.selectedSegmentIndex = 0
        case Constants.Properties.moneyTransactionReasonKeyForOutflow:
            inOutSegment.selectedSegmentIndex = 1
        default:
            print("Reason key is free")
        }
    }
    
    @IBAction func saveButtonClick(_ sender: Any) {
    }
}
