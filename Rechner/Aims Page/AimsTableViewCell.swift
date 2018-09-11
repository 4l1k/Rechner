//
//  AimsTableViewCell.swift
//  Rechner
//
//  Created by Aliagha Seyidov on 9/11/18.
//  Copyright © 2018 Aliagha Seyidov. All rights reserved.
//

import UIKit

class AimsTableViewCell: UITableViewCell {
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var cellItem: Setting = Setting(imageName: "wallet", title: "lorem") {
        didSet {
            label.text = cellItem.settingTitle ?? ""
            imageV.image = cellItem.settingImage ?? UIImage()
        }
    }
    
    convenience init() {
        self.init()
    }
}
