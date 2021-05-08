//
//  PayoneerCell.swift
//  Payoneer
//
//  Created by Rotimi Joshua on 06/05/2021.
//

import UIKit



class PayMethodCell: UITableViewCell {
    
    var info: Applicable? {

           didSet{
            guard
                let name = info?.label,
                let image = info?.links?.logo
            else {
                
                   return
               }

            methodTitle.text = name
            methodImageView.downloaded(from: image)
           }
       }
       
    lazy var backgroundCard: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.backgroundColor = UIColor.secondarySystemBackground.withAlphaComponent(0.7)
        view.clipsToBounds = true
        return view
    }()
    
    lazy var methodImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var methodTitle: UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        title.textColor = .black
        title.font = UIFont.systemFont(ofSize: 15)
         return title
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        selectionStyle = .none
        addSubviews()
        setConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubviews() {
        contentView.addSubview(backgroundCard)
        contentView.addSubview(methodImageView)
        contentView.addSubview(methodTitle)
    }

    func setConstraints() {
        backgroundCard.anchor(top: self.topAnchor, left: self.leftAnchor, right: self.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16, height: 60)
        
        methodImageView.centerY(inView: backgroundCard)
        methodImageView.anchor(left: backgroundCard.leftAnchor, paddingLeft: 16, width: 50, height: 50)
        
        methodTitle.centerY(inView: backgroundCard)
        methodTitle.anchor(left: methodImageView.rightAnchor, right: self.rightAnchor,  paddingTop: 4, paddingLeft: 8, paddingRight: 8)
        
    }
}


