//
//  EditReasonTableViewCell.swift
//  Rechner
//
//  Created by Aliagha Seyidov on 9/6/18.
//  Copyright © 2018 Aliagha Seyidov. All rights reserved.
//

import UIKit


class EditReasonTableViewCell: UITableViewCell {
    @IBOutlet weak var editTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    convenience init() {
        self.init()
    }
    
    var cellItem: [String : Any] = ["" : ""] {
        didSet {
            editTitle.text = cellItem[Constants.Dictionaries.ReasonKeys.reason] as? String
        }
    }
    
    private func setup() {
        
    }
}
