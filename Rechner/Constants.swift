//
//  Constants.swift
//  Rechner
//
//  Created by Aliagha Seyidov on 9/6/18.
//  Copyright © 2018 Aliagha Seyidov. All rights reserved.
//

import UIKit

class Constants {
    
    static let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    struct Colors {
        static let magenta = UIColor(hexString: "8E44AD")! // MAIN MAGENTA COLOR
        static let lightGray = UIColor(hexString: "F5F5F5")! // MAIN GRAY COLOR
        static let green = UIColor(hexString: "29B01E")! // MAIN GREEN
        static let red = UIColor(hexString: "D91E18")! // MAIN RED
    }
    
    struct Properties {
        static let moneyTransactionReasonKeyForIncome = "MONEY_TRANSACTION_REASON_KEY_FOR_INCOME"
        static let moneyTransactionReasonKeyForOutflow = "MONEY_TRANSACTION_REASON_KEY_FOR_OUTFLOW"
        static let moneyTransactionKey = "MONEY_TRANSACTION_KEY"
    }
    
    struct Dictionaries {
        struct ReasonKeys {
            static let reason = "REASON_TEXT"
            static let date = "REASON_DATE"
        }
        struct TransactionKeys {
            static let count = "COUNT"
            static let currency = "CURRENCY"
            static let inOut = "IN_OR_OUT"
            static let reason = "REASON"
            static let spendType = "SPEND_TYPE"
            static let date = "TRANSACTION_DATE"
        }
    }
    
    struct Notifs {
        struct Warning {
            static let title = "Warning!"
            static let subtitle = "Please fill all content to save something"
        }
        
        struct Success {
            static let title = "Success!"
            static let subtitle = "Your data successfully saved"
        }
    }
    
    struct Arrays {
        static let moneyTransactionReasonArray =
            [Setting(imageName: "addReason", title: "Add transaction reason"),
             Setting(imageName: "editReason", title: "Edit transaction reasons"),
             Setting(imageName: "garbage", title: "Delete reason settings")]
        
        static let aimArray =
            [Setting(imageName: "aim", title: "Add aim"),
             Setting(imageName: "aim", title: "Edit aim")]
    }
    
    struct Style {
        static let cornerRadius:CGFloat = 5.0
    }
    
    struct VCIdentifiers {
        static let ATRVC = "ATRVC"
        static let ETRVC = "ETRVC"
        static let SRVC = "SRVC"
        static let AAVC = "AAVC"
    }
    
    struct NotificationKeys {
        static let reloadReasons = "RELOAD_REASONS"
        static let reloadTransactions = "RELOAD_TRANSACTIONS"
    }
}

class Setting {
    var settingImage: UIImage?
    var settingTitle: String?
    
    required init(imageName: String, title: String) {
        settingImage = UIImage(named: imageName)
        settingTitle = title
    }
}
