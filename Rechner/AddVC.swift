//
//  AddVC.swift
//  Rechner
//
//  Created by Aliagha Seyidov on 9/5/18.
//  Copyright © 2018 Aliagha Seyidov. All rights reserved.
//

import UIKit
import DropDown
import ChameleonFramework
import Locksmith
import NotificationBannerSwift

class AddVC: GeneralViewController {
    
    @IBOutlet weak var moneyTextField: UITextField!
    @IBOutlet weak var currencySegment: UISegmentedControl!
    @IBOutlet weak var inOutSegment: UISegmentedControl!
    @IBOutlet weak var reasonButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var spendTypeSegment: UISegmentedControl!
    
    let reasonDropdown = DropDown();
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  try? Locksmith.deleteDataForUserAccount(userAccount: Constants.Properties.moneyTransactionKey)
      //  try? Locksmith.deleteDataForUserAccount(userAccount: Constants.Properties.moneyTransactionReasonKeyForOutflow)
    }
    
    override func reloadReasonData() {
        let isOut = Bool(truncating: inOutSegment.selectedSegmentIndex as NSNumber)
        let key = isOut ? Constants.Properties.moneyTransactionReasonKeyForOutflow : Constants.Properties.moneyTransactionReasonKeyForIncome
        setDropdownSource(key)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setup()
        dropdownSetup()
    }
    
    private func setup() {
        reasonButton.layer.cornerRadius = Constants.Style.cornerRadius
        addButton.layer.cornerRadius = Constants.Style.cornerRadius
        let isOut = Bool(truncating: inOutSegment.selectedSegmentIndex as NSNumber)
        let key = isOut ? Constants.Properties.moneyTransactionReasonKeyForOutflow : Constants.Properties.moneyTransactionReasonKeyForIncome
        setDropdownSource(key)
    }
    
    private func dropdownSetup() {
        reasonDropdown.anchorView = reasonButton
        reasonDropdown.bottomOffset = CGPoint(x: 0, y: reasonButton.bounds.height - 5)
        reasonDropdown.textColor = Constants.Colors.magenta
        reasonDropdown.backgroundColor = Constants.Colors.lightGray
        reasonDropdown.shadowColor = .clear
        reasonDropdown.cornerRadius = Constants.Style.cornerRadius
        // You can also use localizationKeysDataSource instead. Check the docs.
        
        
        // Action triggered on selection
        reasonDropdown.selectionAction = { [weak self] (index, item) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.reasonButton.setTitle(item, for: .normal)
        }
        reasonDropdown.direction = .bottom
    }
    
    @IBAction func reasonButtonClick(_ sender: Any) {
        reasonDropdown.show()
    }
    
    @IBAction func addButtonClick(_ sender: Any) {
        if validate() {
            
            saveTransaction(
                money: moneyTextField.text ?? "",
                currency: currencySegment.selectedSegmentIndex == 0 ? "€" : "₼",
                inOut: inOutSegment.selectedSegmentIndex == 0 ? "In" : "Out",
                reason: reasonButton.titleLabel?.text ?? "",
                spendType: spendTypeSegment.selectedSegmentIndex == 0 ? "With card" : "Cash")
        } else {
            showErrorBanner()
        }
    }
    
    @IBAction func inOutSegmentValueChanged(_ sender: Any) {
        let isOut = Bool(truncating: (sender as! UISegmentedControl).selectedSegmentIndex as NSNumber)
        let key = isOut ? Constants.Properties.moneyTransactionReasonKeyForOutflow : Constants.Properties.moneyTransactionReasonKeyForIncome
        reasonButton.setTitle("Select reason", for: UIControlState())
        
        setDropdownSource(key)
    }
    
    private func setDropdownSource(_ key: String) {
        var source = ["Select reason"]
        
        if let data = getReasonData(key) {
            for item in data {
                let data2 = item.value as! [String : Any]
                source.append(data2[Constants.Dictionaries.ReasonKeys.reason] as! String)
            }
        }
        reasonDropdown.dataSource = source
    }
    
    private func validate() -> Bool {
        if moneyTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" {
            return false
        } else {
            return true
        }
    }
}
