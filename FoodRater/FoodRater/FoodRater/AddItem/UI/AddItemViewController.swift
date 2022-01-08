//
//  AddItemViewController.swift
//  FoodRater
//
//  Created by Borna Ungar on 01.01.2022..
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift
class AddItemViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Item name (needed)"
        return label
    }()
    
    let nameTxtField: UITextField = {
        let txtField = UITextField()
        txtField.layer.borderWidth = 1
        return txtField
    }()
    
    let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "Item comment (optional)"
        return label
    }()
    
    let commentTxtField: UITextField = {
        let txtField = UITextField()
        txtField.layer.borderWidth = 1
        return txtField
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "Item rating (needed)"
        return label
    }()
    
    let ratingContainerView: UIStackView = {
        let view = UIStackView()
        view.distribution = .equalCentering
        view.axis = .horizontal
        view.spacing = 10
        view.layoutMargins = UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)
        view.isLayoutMarginsRelativeArrangement = true
        return view
    }()
    
    let oneRatingButton: UIButton = {
        let btn = UIButton()
        btn.layer.borderWidth = 1
        btn.setTitle("1", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.setTitleColor(UIColor.green, for: .selected)
        return btn
    }()
    
    let twoRatingButton: UIButton = {
        let btn = UIButton()
        btn.layer.borderWidth = 1
        btn.setTitle("2", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.setTitleColor(UIColor.green, for: .selected)
        return btn
    }()
    
    let threeRatingButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("3", for: .normal)
        btn.layer.borderWidth = 1
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.setTitleColor(UIColor.green, for: .selected)
        return btn
    }()
    
    let fourRatingButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("4", for: .normal)
        btn.layer.borderWidth = 1
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.setTitleColor(UIColor.green, for: .selected)
        return btn
    }()
    
    let fiveRatingButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("5", for: .normal)
        btn.layer.borderWidth = 1
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.setTitleColor(UIColor.green, for: .selected)
        return btn
    }()
    
    let imageLabel: UILabel = {
        let label = UILabel()
        label.text = "Item image"
        return label
    }()
    
    let itemImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.borderWidth = 1
        iv.image = UIImage(named: "default.png")
        return iv
    }()
    
    let imageButton: UIButton = {
        let btn = UIButton()
        btn.layer.borderWidth = 1
        btn.setTitle("Select gallery image", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        return btn
    }()
    
    let submitButton: UIButton = {
        let btn = UIButton()
        btn.layer.borderWidth = 1
        btn.setTitle("Submit", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        return btn
    }()
    
    let viewModel: AddItemViewModel
    
    init(viewModel: AddItemViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        initializeButton()
    }
}

private extension AddItemViewController {
    
    func setupUI(){
        self.hideKeyboardWhenTappedAround()
        view.backgroundColor = .white
        view.addSubviews(views: nameLabel, nameTxtField, commentLabel, commentTxtField, ratingLabel, ratingContainerView, itemImageView, imageLabel, imageButton, submitButton)
        
        ratingContainerView.addArrangedSubview(oneRatingButton)
        ratingContainerView.addArrangedSubview(twoRatingButton)
        ratingContainerView.addArrangedSubview(threeRatingButton)
        ratingContainerView.addArrangedSubview(fourRatingButton)
        ratingContainerView.addArrangedSubview(fiveRatingButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        nameLabel.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(25)
            make.leading.equalToSuperview().offset(25)
        }
        
        nameTxtField.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        commentLabel.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(nameTxtField.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(25)
        }
        
        commentTxtField.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(commentLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        ratingLabel.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(commentTxtField.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(25)
        }
        
        ratingContainerView.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(ratingLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(25)
        }
        
        imageLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(ratingContainerView.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(25)
        }
        
        itemImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(imageLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(100)
        }
        
        imageButton.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(itemImageView.snp.bottom).offset(10)
            make.width.equalTo(200)
            make.centerX.equalToSuperview()
        }
        
        submitButton.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(imageButton.snp.bottom).offset(50)
            make.width.equalTo(100)
            make.centerX.equalToSuperview()
        }
    }
    
    func initializeButton(){
        let buttons: [UIButton] = [oneRatingButton, twoRatingButton, threeRatingButton, fourRatingButton, fiveRatingButton]
        
        buttons.forEach{ button in
            button.rx.tap
                .subscribe(onNext: { _ in
                    buttons.forEach {
                        $0.isSelected = false
                        $0.backgroundColor = .white
                    }
                    button.isSelected = true
                    button.backgroundColor = .systemYellow
                    if let buttonRating = button.currentTitle {
                        self.viewModel.rating = Int(buttonRating)
                    }
                }).disposed(by: disposeBag)
        }
        
        imageButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                ImagePickerManager().pickImage(self){ (image, url) in
                    self.itemImageView.image = image
                }
            }).disposed(by: disposeBag)
        
        submitButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                if let name = self.nameTxtField.text, let newRating = self.viewModel.rating, let imageData = (itemImageView.image?.jpegData(compressionQuality: 0.5)), let itemComment = commentTxtField.text {
                    print("NEW SIZE ->>>>> \(imageData.count)")
                    // Realm limit is 25MB(~26000000 bytes in binary)
                    if (imageData.count >= 25000000) {
                        print("Image size too big.")
                    } else {
                        self.viewModel.addItem(name: name, rating: newRating, imagePath: imageData, comment: itemComment)
                        navigationController?.popViewController(animated: true)
                    }
                }
            }).disposed(by: disposeBag)
    }
}
