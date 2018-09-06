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

class AddReasonVC: UIViewController {
    
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
    
    private func validate() -> Bool {
        if reasonTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" {
            return false
        } else {
            return true
        }
    }
    
    private func getReasonData(_ key: String) -> [String : Any]? {
        
        let data = Locksmith.loadDataForUserAccount(userAccount: key)
        return data
    }
    
    @IBAction func addButtonClick(_ sender: Any) {
        view.endEditing(true)
        
        if validate() {
            
            let isOut = Bool(truncating: inOutSegment.selectedSegmentIndex as NSNumber)
            let key = isOut ? Constants.Properties.moneyTransactionReasonKeyForOutflow : Constants.Properties.moneyTransactionReasonKeyForIncome
            let dataSave = [Constants.Dictionaries.ReasonKeys.reason : reasonTextField.text!,
                        Constants.Dictionaries.ReasonKeys.date : Date()] as [String : Any]
            
            if var data = getReasonData(key) {
                data.updateValue(dataSave, forKey: String(data.count))
                try? Locksmith.updateData(data: data, forUserAccount: key)
            } else {
                
                let data2 = [String(0) : dataSave]
                try? Locksmith.saveData(data: data2, forUserAccount: key)
            }
            let banner = NotificationBanner(title: Constants.Notifs.Success.title, subtitle: Constants.Notifs.Success.subtitle, style: .success)
            banner.show()

        } else {
            let banner = NotificationBanner(title: Constants.Notifs.Warning.title, subtitle: Constants.Notifs.Warning.subtitle, style: .danger)
            banner.show()
        }
    }
    
}
