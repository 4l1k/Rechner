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
}

extension EditReasonVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (getReasonData(key) ?? ["" : ""]).count
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
    
    
}
