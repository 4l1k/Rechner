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

class AddVC: UIViewController {
    
    @IBOutlet weak var moneyTextField: UITextField!
    @IBOutlet weak var currencySegment: UISegmentedControl!
    @IBOutlet weak var inOutSegment: UISegmentedControl!
    @IBOutlet weak var reasonButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    let reasonDropdown = DropDown();
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setup()
        dropdownSetup()
    }
    
    private func setup() {
        reasonButton.layer.cornerRadius = 5
        addButton.layer.cornerRadius = 5
    }
    
    private func dropdownSetup() {
        reasonDropdown.anchorView = reasonButton
        reasonDropdown.bottomOffset = CGPoint(x: 0, y: reasonButton.bounds.height - 5)
        reasonDropdown.textColor = UIColor(hexString: "8E44AD")!
        reasonDropdown.backgroundColor = UIColor(hexString: "F5F5F5")!
        reasonDropdown.shadowColor = .clear
        reasonDropdown.cornerRadius = 5
        // You can also use localizationKeysDataSource instead. Check the docs.
        reasonDropdown.dataSource = [
            "iPhone SE | Black | 64G",
            "Samsung S7",
            "Huawei P8 Lite Smartphone 4G",
            "Asus Zenfone Max 4G",
            "Apple Watwh | Sport Edition",
            "iPhone SE | Black | 64G",
            "Samsung S7",
            "Huawei P8 Lite Smartphone 4G",
            "Asus Zenfone Max 4G",
            "Apple Watwh | Sport Edition"
        ]
        
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
        
    }
}
