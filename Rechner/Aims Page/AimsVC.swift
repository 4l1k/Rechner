//
//  AimsVC.swift
//  Rechner
//
//  Created by Aliagha Seyidov on 9/5/18.
//  Copyright © 2018 Aliagha Seyidov. All rights reserved.
//

import UIKit

class AimsVC: UIViewController {
    @IBOutlet weak var aimsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        aimsTableView.separatorInset = UIEdgeInsets(top: 0, left: view.bounds.width, bottom: 0, right: 0)
    }
}

extension AimsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.Arrays.aimArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! AimsTableViewCell
        cell.cellItem = Constants.Arrays.aimArray[indexPath.row]
        cell.separatorInset = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 20)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var vc: UIViewController?
        switch indexPath.row {
        case 0:
            vc = Constants.storyboard.instantiateViewController(withIdentifier: Constants.VCIdentifiers.AAVC)
        case 1:
            vc = Constants.storyboard.instantiateViewController(withIdentifier: Constants.VCIdentifiers.ETRVC)
        case 2:
            break
            //deleteReasons()
        default:
            break
        }
        
        navigationController?.pushViewController(vc!, animated: true)
    }
}
