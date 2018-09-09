//
//  SummaryTableViewCell.swift
//  Rechner
//
//  Created by Aliagha Seyidov on 9/9/18.
//  Copyright © 2018 Aliagha Seyidov. All rights reserved.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {
    @IBOutlet weak var cashLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var cellItem: [String : Any] = ["" : ""] {
        didSet {
            setup(cellItem)
        }
    }
    
    private func setup(_ data: [String : Any]) {
        var counter: Float = 0.0
        var currency = ""
        for item in data {
            print(item)
            currency = (item.value as! [String : Any])[Constants.Dictionaries.TransactionKeys.currency]  as! String
            var count = Float((item.value as! [String : Any])[Constants.Dictionaries.TransactionKeys.count] as! String)
            print(count ?? 0.0)
            if (item.value as! [String : Any])[Constants.Dictionaries.TransactionKeys.inOut] as! String == "Out" {
                count = -1 * (count ?? 0.0)
            }
            
            counter = counter + (count ?? 0.0)
        }
        
        if counter > 0.0 {
            cashLabel.text = "+"
        } else {
            cashLabel.text = "-"
        }
        
        cashLabel.text = (cashLabel.text ?? "") + String(format: "%.2f", counter) + " " + currency
    }
}
