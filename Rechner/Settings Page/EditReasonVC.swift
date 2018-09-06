//
//  EditReasonVC.swift
//  Rechner
//
//  Created by Aliagha Seyidov on 9/6/18.
//  Copyright © 2018 Aliagha Seyidov. All rights reserved.
//

import UIKit
import Locksmith

class EditReasonVC: UIViewController {
    @IBOutlet weak var editReasonTableView: UITableView!
    var key = Constants.Properties.moneyTransactionReasonKeyForIncome
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editReasonTableView.separatorInset = UIEdgeInsets(top: 0, left: view.bounds.width, bottom: 0, right: 0)
        
    }
    
    func changeDicKey(_ dic: [String : Any]) -> [String : Any] {
        var entry = [String : Any]()
        var i = 0
        
        for item in dic {
            entry[String(i)] = item.value
            i += 1
        }
        return entry
    }
    
    
    private func getReasonData(_ key: String) -> [String : Any]? {
        
        let data = Locksmith.loadDataForUserAccount(userAccount: key)
        return data
    }
    @IBAction func inOutSegmentValueChanged(_ sender: Any) {
        switch (sender as! UISegmentedControl).selectedSegmentIndex {
        case 0:
            key = Constants.Properties.moneyTransactionReasonKeyForIncome
        case 1:
            key = Constants.Properties.moneyTransactionReasonKeyForOutflow
        default:
            break
        }
        editReasonTableView.reloadData()
    }
    
    func toggleDeleteAction(forRowAtIndexPath indexPath: IndexPath) -> UIContextualAction {
        
      
        let action = UIContextualAction(style: .normal,
                                        title: "Delete") { (contextAction: UIContextualAction, sourceView: UIView, completionHandler: (Bool) -> Void) in
                                           
                                            var data = self.getReasonData(self.key)!
                                            data.removeValue(forKey: String(indexPath.row))
                                            
                                            data = self.changeDicKey(data)
                                            try? Locksmith.updateData(data: data, forUserAccount: self.key)
                                                
                                            self.editReasonTableView.reloadData()
                                         
                                                completionHandler(true)
                                           
        }
      
        action.image = UIImage(named: "garbage")
        action.backgroundColor = .white
        return action
    }
    
    func toggleEditAction(forRowAtIndexPath indexPath: IndexPath) -> UIContextualAction {
        
        
        let action = UIContextualAction(style: .normal,
                                        title: "Edit") { (contextAction: UIContextualAction, sourceView: UIView, completionHandler: (Bool) -> Void) in
                                            
                                            
                                            
                                            self.editReasonTableView.reloadRows(at: [indexPath], with: .none)
                                            
                                            completionHandler(true)
                                            
        }
        
        action.image = UIImage(named: "edit")
        action.backgroundColor = .white
        return action
    }
}

extension EditReasonVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getReasonData(key) == nil ? 0 : getReasonData(key)!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! EditReasonTableViewCell
        let data = getReasonData(key)
        cell.cellItem = data![String(indexPath.row)] as! [String : Any]
        cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var vc: UIViewController?
        switch indexPath.row {
        case 0:
            vc = Constants.storyboard.instantiateViewController(withIdentifier: Constants.VCIdentifiers.ATRVC)
        case 1:
            vc = Constants.storyboard.instantiateViewController(withIdentifier: Constants.VCIdentifiers.ETRVC)
        default:
            break
        }
        
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = self.toggleDeleteAction(forRowAtIndexPath: indexPath)
        let editAction = self.toggleEditAction(forRowAtIndexPath: indexPath)
        let swipeConfig = UISwipeActionsConfiguration(actions: [editAction, deleteAction])
        return swipeConfig
    }
    
}
