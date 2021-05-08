//
//  PayoneerVC+CollView.swift
//  Payoneer
//
//  Created by Rotimi Joshua on 06/05/2021.
//


import UIKit

extension PayoneerVC : UITableViewDelegate, UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if paymentLists.count != 0 {
                tableView.isHidden = false
                emptyStateImageView.isHidden = true
                emptyStateTitle.isHidden = true
            }else {
                tableView.isHidden = true
                emptyStateImageView.isHidden = false
                emptyStateTitle.isHidden = false
                 
            }
            return paymentLists.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! PayMethodCell
        let paymentObj = paymentLists[indexPath.row]
        cell.info = paymentObj
        return cell
    }
   
}
