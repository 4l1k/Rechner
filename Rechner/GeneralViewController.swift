//
//  GeneralViewController.swift
//  Rechner
//
//  Created by Aliagha Seyidov on 9/8/18.
//  Copyright © 2018 Aliagha Seyidov. All rights reserved.
//

import UIKit
import Locksmith
import NotificationBannerSwift


class GeneralViewController: UIViewController {
    
    let nc = NotificationCenter.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nc.addObserver(self, selector: #selector(reloadReasonData), name: Notification.Name(Constants.NotificationKeys.reloadReasons), object: nil)
        nc.addObserver(self, selector: #selector(reloadTransactionData), name: Notification.Name(Constants.NotificationKeys.reloadTransactions), object: nil)
    }
    
    @objc public func reloadReasonData() {
        
    }
    
    @objc public func reloadTransactionData() {
        
    }
    
    
    public func getReasonData(_ key: String) -> [String : Any]? {
        let data = Locksmith.loadDataForUserAccount(userAccount: key)
        return data
    }
    
    public func getTransactionData() -> [String : Any]? {
        let data = Locksmith.loadDataForUserAccount(userAccount: Constants.Properties.moneyTransactionKey)
        return data
    }
    
    public func deleteReasons() {
        try? Locksmith.deleteDataForUserAccount(userAccount: Constants.Properties.moneyTransactionReasonKeyForIncome)
        try? Locksmith.deleteDataForUserAccount(userAccount: Constants.Properties.moneyTransactionReasonKeyForOutflow)
        showSuccessBanner()
    }
    
    public func updateReason(reasonText: String, isOut: Bool, reasonKey: String, selectedKey: Int) {
        var data = Locksmith.loadDataForUserAccount(userAccount: reasonKey)! as [String : Any]
        var data2 = Locksmith.loadDataForUserAccount(userAccount: Constants.Properties.moneyTransactionKey)! as [String : Any]
        print(data2)
        
        for item in data2 {
            var item2 = item.value as! [String : Any]
            if ((data[String(selectedKey)] as! [String : Any])[Constants.Dictionaries.ReasonKeys.reason]) as! String == item2[Constants.Dictionaries.TransactionKeys.reason] as! String {
                
                let save = [
                    Constants.Dictionaries.TransactionKeys.count : item2[Constants.Dictionaries.TransactionKeys.count] ?? "",
                    Constants.Dictionaries.TransactionKeys.currency : item2[Constants.Dictionaries.TransactionKeys.currency] ?? "",
                    Constants.Dictionaries.TransactionKeys.inOut : item2[Constants.Dictionaries.TransactionKeys.inOut] ?? "",
                    Constants.Dictionaries.TransactionKeys.reason : reasonText,
                    Constants.Dictionaries.TransactionKeys.spendType : item2[Constants.Dictionaries.TransactionKeys.spendType] ?? "",
                    Constants.Dictionaries.TransactionKeys.date : item2[Constants.Dictionaries.TransactionKeys.date] ?? ""] as [String : Any]
                data2.updateValue(save, forKey: item.key)
            }
            
            
            
        }
        print(data2)
        try? Locksmith.updateData(data: data2, forUserAccount: Constants.Properties.moneyTransactionKey)
        
        let key = isOut ? Constants.Properties.moneyTransactionReasonKeyForOutflow : Constants.Properties.moneyTransactionReasonKeyForIncome
        let dataSave = [Constants.Dictionaries.ReasonKeys.reason : reasonText,
                        Constants.Dictionaries.ReasonKeys.date : Date()] as [String : Any]
        data.updateValue(dataSave, forKey: String(selectedKey))
        try? Locksmith.updateData(data: data, forUserAccount: key)
        showSuccessBanner()
        nc.post(name: Notification.Name(Constants.NotificationKeys.reloadReasons), object: nil)
    }
    
    public func saveReason(_ reasonText: String, isOut: Bool) {
        let key = isOut ? Constants.Properties.moneyTransactionReasonKeyForOutflow : Constants.Properties.moneyTransactionReasonKeyForIncome
        let dataSave = [Constants.Dictionaries.ReasonKeys.reason : reasonText,
                        Constants.Dictionaries.ReasonKeys.date : Date()] as [String : Any]
        
        if var data = getReasonData(key) {
            data.updateValue(dataSave, forKey: String(data.count))
            try? Locksmith.updateData(data: data, forUserAccount: key)
        } else {
            
            let data2 = [String(0) : dataSave]
            try? Locksmith.saveData(data: data2, forUserAccount: key)
        }
        showSuccessBanner()
        nc.post(name: Notification.Name(Constants.NotificationKeys.reloadReasons), object: nil)
    }
    
    public func saveTransaction(money: String, currency: String, inOut: String, reason: String, spendType: String) {
        let save = [Constants.Dictionaries.TransactionKeys.count : money,
                    Constants.Dictionaries.TransactionKeys.currency : currency,
                    Constants.Dictionaries.TransactionKeys.inOut : inOut,
                    Constants.Dictionaries.TransactionKeys.reason : reason,
                    Constants.Dictionaries.TransactionKeys.spendType : spendType,
                    Constants.Dictionaries.TransactionKeys.date : Date()] as [String : Any]
        
        if var data = getTransactionData() {
            data.updateValue(save, forKey: String(data.count))
            try? Locksmith.updateData(data: data, forUserAccount: Constants.Properties.moneyTransactionKey)
        } else {
            let data2 = [String(0) : save]
            try? Locksmith.saveData(data: data2, forUserAccount: Constants.Properties.moneyTransactionKey)
        }
        showSuccessBanner()
        nc.post(name: Notification.Name(Constants.NotificationKeys.reloadTransactions), object: nil)
    }
    
    public func showSuccessBanner() {
        let banner = NotificationBanner(title: Constants.Notifs.Success.title, subtitle: Constants.Notifs.Success.subtitle, style: .success)
        banner.show()
    }
    
    public func showErrorBanner() {
        let banner = NotificationBanner(title: Constants.Notifs.Warning.title, subtitle: Constants.Notifs.Warning.subtitle, style: .danger)
        banner.show()
    }
    
    
    public func validateText(_ sender: UITextField) -> Bool {
        if sender.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return false
        } else {
            return true
        }
    }
}
