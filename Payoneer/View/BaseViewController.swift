//
//  BaseViewController.swift
//  Payoneer
//
//  Created by Rotimi Joshua on 06/05/2021.
//

import Foundation
import UIKit

class BaseViewController: ViewController {
    
    
    func simpleAlert(alertType:UIAlertController.Style?, message:String){
        let actionSheet = UIAlertController(title: "Error", message: message, preferredStyle: alertType ?? .alert)
        actionSheet.addAction(UIAlertAction(title: "OKAY", style: .cancel, handler: nil))
        present(actionSheet, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            actionSheet.dismiss(animated: true, completion: nil)
        }
        
        
    }
    
    func showLoader(){
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func dismissLoader(){
        dismiss(animated: false, completion: nil)
    }
}
