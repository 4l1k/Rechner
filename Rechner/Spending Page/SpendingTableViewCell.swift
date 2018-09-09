//
//  SpendingTableViewCell.swift
//  Rechner
//
//  Created by Aliagha Seyidov on 9/8/18.
//  Copyright © 2018 Aliagha Seyidov. All rights reserved.
//

import UIKit

class SpendingTableViewCell: UITableViewCell {
    
    let formatter = DateFormatter()
    @IBOutlet weak var line1: UIView!
    @IBOutlet weak var line2: UIView!
    @IBOutlet weak var line3: UIView!
    @IBOutlet weak var reasonLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cashLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        formatter.dateFormat = "E MMM dd, yyyy"
        
    }
    
    convenience init() {
        self.init()
    }
    
    var cellItem: [String : Any] = ["" : ""] {
        didSet {
            setup(cellItem)
        }
    }
    
    private func setup(_ data: [String : Any]) {
        switch data[Constants.Dictionaries.TransactionKeys.inOut] as! String {
        case "In":
            line1.backgroundColor = Constants.Colors.green
            line2.backgroundColor = Constants.Colors.green
            line3.backgroundColor = Constants.Colors.green
            reasonLabel.textColor = Constants.Colors.green
            timeLabel.textColor = Constants.Colors.green
            cashLabel.textColor = Constants.Colors.green
            cashLabel.text = "+"
            break
        case "Out":
            line1.backgroundColor = Constants.Colors.red
            line2.backgroundColor = Constants.Colors.red
            line3.backgroundColor = Constants.Colors.red
            reasonLabel.textColor = Constants.Colors.red
            timeLabel.textColor = Constants.Colors.red
            cashLabel.textColor = Constants.Colors.red
            cashLabel.text = "-"
        default:
            break
        }
        
        reasonLabel.text = data[Constants.Dictionaries.TransactionKeys.reason] as? String
        timeLabel.text = formatter.string(from: data[Constants.Dictionaries.TransactionKeys.date] as! Date)
        cashLabel.text = cashLabel.text! + (data[Constants.Dictionaries.TransactionKeys.count] as! String) + " " + (data[Constants.Dictionaries.TransactionKeys.currency] as! String)
    }
}
