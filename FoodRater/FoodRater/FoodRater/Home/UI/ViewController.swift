//
//  ViewController.swift
//  FoodRater
//
//  Created by Borna Ungar on 19.12.2021..
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.quicksandBold(size: 16)
        label.text = "FoodRater 0.1"
        return label
    }()
    
    let progressView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        return view
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .lightGray
        return tv
    }()
    
    let emptyNoticeLabel: UILabel = {
        let label = UILabel()
        label.text = "Your list is currently empty."
        label.textColor = .gray
        label.isHidden = true
        return label
    }()
    
    let infoButton: UIButton = {
        let infoButton = UIButton(type: .infoLight)
        return infoButton
    }()
    
    let addButton: UIButton = {
        let infoButton = UIButton(type: .contactAdd)
        return infoButton
    }()
    
    let viewModel: ItemViewModel
    
    init(viewModel: ItemViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadListSubject.onNext(())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setupUI()
        setupTableView()
        initializeVM()
    }
    
    func setupUI() {
        
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: infoButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
        view.addSubviews(views: progressView, titleLabel, tableView, emptyNoticeLabel)
        
        view.bringSubviewToFront(progressView)
        view.backgroundColor = .white
        setupConstraints()
    }
    
    func setupConstraints() {
        
        titleLabel.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
        }
        
        progressView.snp.makeConstraints{ (make) -> Void in
            make.centerX.centerY.equalToSuperview()
        }
        
        emptyNoticeLabel.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().offset(10)
        }
        
        tableView.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func infoButtonTapped() {
        showInfoAlert(alertText: "Instructions", alertMessage: "Food rating app\n. Add items and give them a 1-5 ranking.")
    }
    
    @objc func addButtonTapped() {
        let alert = UIAlertController(title: "Add item/group", message: "Choose to add a new group or an item to an existing group", preferredStyle: UIAlertController.Style.actionSheet)
        alert.addAction(UIAlertAction(title: "Add item", style: UIAlertAction.Style.default, handler: { [unowned self] _ in
            navigationController?.pushViewController(AddItemViewController(viewModel: AddItemViewModelImpl(itemRepository: FoodRaterRepositoryImpl())), animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Add group", style: UIAlertAction.Style.default, handler: { [unowned self] _ in
            showInfoAlert(alertText: "Add group", alertMessage: "To be implemented later.")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setupTableView() {
        registerCells()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func registerCells() {
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: "itemTableViewCell")
    }
    
    func initializeVM(){
        disposeBag.insert(viewModel.initializeViewModelObservables())
        
        initializeLoaderObservable(subject: viewModel.loaderSubject).disposed(by: disposeBag)
        initializeListDataObservable(subject: viewModel.listRelay).disposed(by: disposeBag)
    }
    
    func initializeLoaderObservable(subject: ReplaySubject<Bool>) -> Disposable {
        return subject
            .observe(on: MainScheduler.instance)
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { [unowned self] (status) in
                if status {
                    showLoader()
                } else {
                    hideLoader()
                }
            })
    }
    
    func initializeListDataObservable(subject: BehaviorRelay<[Item]>) -> Disposable {
        return subject
            .observe(on: MainScheduler.instance)
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { [unowned self] (items) in
                if !items.isEmpty {
                    emptyNoticeLabel.isHidden = true
                } else {
                    emptyNoticeLabel.isHidden = false
                }
                viewModel.loaderSubject.onNext(true)
                tableView.reloadData()
                viewModel.loaderSubject.onNext(false)
            })
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let itemCell = tableView.dequeueReusableCell(withIdentifier: "itemTableViewCell", for: indexPath) as? ItemTableViewCell else {
            print("failed to dequeue the wanted cell")
            return UITableViewCell()
        }
        
        let items = viewModel.listRelay.value
        let item = items[indexPath.row]
        itemCell.configureCell(itemName: item.name, itemImagePath: item.imagePath, itemRating: item.rating)
        
        return itemCell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let items = viewModel.listRelay.value
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(viewModel.listRelay.value[indexPath.row].createdAt)
        print("Comment: \(viewModel.listRelay.value[indexPath.row].comment)")
    }
    
}

extension ViewController {
    
    func showLoader() {
        progressView.isHidden = false
        progressView.startAnimating()
    }
    
    func hideLoader() {
        progressView.isHidden = true
        progressView.stopAnimating()
    }
}
