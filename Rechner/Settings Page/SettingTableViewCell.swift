//
//  SettingTableViewCell.swift
//  Rechner
//
//  Created by Aliagha Seyidov on 9/6/18.
//  Copyright © 2018 Aliagha Seyidov. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var settingImage: UIImageView!
    @IBOutlet weak var settingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    convenience init() {
        self.init()
    }
    
    var cellItem: Setting = Setting(imageName: "wallet", title: "lorem") {
        didSet {
            settingLabel.text = cellItem.settingTitle ?? ""
            settingImage.image = cellItem.settingImage ?? UIImage()
        }
    }
    
    private func setup() {
        settingImage.tintColor = Constants.Colors.magenta
    }
}
