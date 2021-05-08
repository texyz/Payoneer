//
//  PayoneerVC.swift
//  Payoneer
//
//  Created by Rotimi Joshua on 06/05/2021.
//

import UIKit

class PayoneerVC: BaseViewController {
    let nc = NotificationCenter.default
    
    var paymentLists:[Applicable] = []
    
    var cellID = "Cell"
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        configureTableView()
        configureEmptyState()
        showLoader()
        observer()
        
        
    }
    
    lazy var emptyStateImageView: UIImageView = {
        let image = UIImage(named: "emptyBox")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var emptyStateTitle: UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        title.textColor = .black
        title.text = "Payment methods not available"
        title.font = UIFont.systemFont(ofSize: 16)
        return title
    }()
    
    
    
    //Configure Table view here
    func configureTableView(){
        
        //view backgroundColor
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        //Navbar title
        self.title = "Payment Methods"
        tableView.allowsSelection = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        setTableViewDelegate()
        tableView.rowHeight = 80
        tableView.showsVerticalScrollIndicator = false
        tableView.register(PayMethodCell.self, forCellReuseIdentifier: cellID)
        //pin tablview to the edges of the screen
        tableView.pinToEdges(to: view)
    }
    
    
    func setTableViewDelegate(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configureEmptyState(){
        view.addSubview(emptyStateImageView)
        view.addSubview(emptyStateTitle)
        
        emptyStateImageView.centerY(inView: tableView)
        emptyStateImageView.centerX(inView: tableView)
        emptyStateImageView.anchor(width: 100, height: 100)
        
        emptyStateTitle.centerX(inView: tableView)
        emptyStateTitle.anchor(top: emptyStateImageView.bottomAnchor)
        
        
    }
    
    func observer(){
        nc.addObserver(self, selector: #selector(onFetchPaymentDataAction), name: Notification.Name("OnFetchPaymentDataAction"), object: nil)
    }
    
    func fetchData(){
        Networking.sharedInstance.getPaymentList{[weak self] result in
            DispatchQueue.main.async{
                self?.dismissLoader()
            }
            
            switch result{
            case .failure(let error):
                DispatchQueue.main.async{
                    
                    // any UI related code
                    self?.simpleAlert(alertType: .alert, message: error.localizedDescription)
                }
                
                
            case .success(let paymentList):
                let paymentDict:[String:  PaymentMethodLists] = ["paymentObj": paymentList]
                self?.nc.post(name: Notification.Name("OnFetchPaymentDataAction"), object: nil, userInfo: paymentDict)
            }
        }
    }
    
    @objc func onFetchPaymentDataAction(notification: NSNotification){
        if let obj = notification.userInfo?["paymentObj"] as? PaymentMethodLists {
            DispatchQueue.main.async{
                // any UI related code
                self.paymentLists = obj.networks?.applicable ?? []
                self.tableView.reloadData()
            }
        }
    }
    
    deinit {
        nc.removeObserver(self, name: Notification.Name("OnFetchPaymentDataAction"), object: nil)
    }
}


