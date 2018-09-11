//
//  SpendingVC.swift
//  Rechner
//
//  Created by Aliagha Seyidov on 9/5/18.
//  Copyright © 2018 Aliagha Seyidov. All rights reserved.
//

import UIKit

class SpendingVC: GeneralViewController {
    @IBOutlet weak var spendigTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         spendigTableView.separatorInset = UIEdgeInsets(top: 0, left: view.bounds.width, bottom: 0, right: 0)
    }
    
    override func reloadTransactionData() {
        spendigTableView.reloadData()
    }
}

extension SpendingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = getTransactionData()
        return data != nil ? (data?.count)! + 1 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = getTransactionData()
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SpendingTableViewCell
        cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        if indexPath.row == data?.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2") as! SummaryTableViewCell
            cell.cellItem = data!
            cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            return cell
        } else {
            cell.cellItem = data?[String(indexPath.row)] as! [String : Any]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = getTransactionData() ?? ["" : ""]
        if indexPath.row == data.count {
            return 40
        }
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
