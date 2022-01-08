//
//  ItemTableViewCell.swift
//  FoodRater
//
//  Created by Borna Ungar on 21.12.2021..
//

import Foundation
import UIKit
import Kingfisher
import SnapKit
import Rswift
import RxSwift

class ItemTableViewCell: UITableViewCell {
    
    let cellView: UIView = {
        let view = UIView()
        return view
    }()
    
    let spacer: UIView = {
        let spacer = UIView()
        spacer.backgroundColor = .white
        return spacer
    }()
    
    let itemImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.black.cgColor
        return iv
    }()
    
    let itemRatingLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.quicksandRegular(size: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let itemNameLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.quicksandBold(size: 17)
        label.textColor = .white
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    // To be added later
//    let itemGroupLabel: UILabel = {
//        let label = UILabel()
//        label.font = R.font.quicksandMedium(size: 19)
//        label.textColor = .white
//        label.numberOfLines = 1
//        label.lineBreakMode = .byTruncatingTail
//        return label
//    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(itemName: String, itemImagePath: Data, itemRating: Int) {
        itemNameLabel.text = itemName
        itemRatingLabel.text = addRatingStars(itemRating)
        itemImageView.image = UIImage(data: itemImagePath)
    }
}

private extension ItemTableViewCell {
    
    func setupUI() {
        contentView.backgroundColor = .gray
        self.backgroundColor = .gray
        spacer.backgroundColor = .white
        self.selectionStyle = .none
        
        contentView.addSubviews(views: cellView, spacer)
        cellView.addSubviews(views: itemNameLabel, itemRatingLabel, itemImageView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        cellView.snp.makeConstraints { (make) -> Void in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview()
        }
        
        spacer.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(cellView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(10)
        }
        
        itemImageView.snp.makeConstraints { (make) -> Void in
            make.top.leading.equalToSuperview()
            make.width.height.equalTo(100)
        }
        
        itemRatingLabel.snp.makeConstraints { (make) -> Void in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(itemImageView.snp.trailing)
            make.trailing.equalTo(itemImageView.snp.trailing).offset(30)
        }
        
        itemNameLabel.snp.makeConstraints{ (make) -> Void in
            make.centerY.equalToSuperview().offset(-15)
            make.leading.equalTo(itemRatingLabel.snp.trailing).offset(5)
            make.trailing.equalToSuperview().offset(-5)
        }
        
//        itemGroupLabel.snp.makeConstraints{ (make) -> Void in
//            make.centerY.equalToSuperview().offset(15)
//            make.leading.equalTo(itemRatingLabel.snp.trailing).offset(5)
//            make.trailing.equalToSuperview().offset(-5)
//        }
//
    }
}

private extension ItemTableViewCell {
    
    func addRatingStars(_ rating: Int) -> String {
        
        var string = ""
        for i in 1...rating {
            
            if i == rating {
                string.append("⭐︎")
            }else {
                string.append("⭐︎\n")
            }
        }
        return string
    }
    
}
