//
//  HomeVC.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 25/02/2025.
//

import UIKit
import SwiftUI
class HomeVC: DefaultVC {
    private let viewModel = CoinsViewModel()
    private lazy var logoImg: UIImageView = {
        let iv = UIImageView(uiImage: .systemImage("person.circle.fill")
            .withTintColor(.header, renderingMode: .alwaysOriginal))
        iv.clipsToBounds = true
        return iv
    }()
    private lazy var notificationIv: UIImageView = {
        let iv = UIImageView(uiImage: .systemImage("bell.circle.fill")
            .withTintColor(.header, renderingMode: .alwaysOriginal))
        iv.clipsToBounds = true
        return iv
    }()
    private lazy var greetingLb: UILabel = {
        return UILabel(text: getTimeGreetingVerb() + ",", font: .sourceSanBold())
    }()
    
    private lazy var descLb: UILabel = {
        return UILabel(text: .localizable(.homeDesc), font: .sourceSanBold(16), textColor: .header)
    }()
    
    private let tableView: UITableView = {
        let tblView = UITableView()
        tblView.allowsSelectionDuringEditing = false
        tblView.contentInsetAdjustmentBehavior = .never
        tblView.translatesAutoresizingMaskIntoConstraints = false
        tblView.allowsSelection = true
        tblView.allowsMultipleSelection = false
        tblView.separatorStyle = .none
        tblView.contentInset = .zero
        tblView.tableHeaderView = nil
        tblView.backgroundColor = .clear
        if #available(iOS 15.0, *) {
            tblView.sectionHeaderTopPadding = 0
        }
        return tblView
    }()
    
    private lazy var sortSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: CoinSortOption.allCases.map { $0.displayName })
        control.selectedSegmentIndex = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        control.addTarget(self, action: #selector(sortCoinsChanged(_:)), for: .valueChanged)
        return control
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .large)
        ai.color = .primaryApp
        ai.hidesWhenStopped = true
        return ai
    }()
    lazy var noDataContainer : NoShowView = {
        let vw = NoShowView()
        vw.btnRefresh.isHidden = false
        vw.isHidden = true
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        bindViewModel()
        fetchData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
       
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }


    
    private func setUpUI(){
        setUpConstraints()
        tableView.tableFooterView = activityIndicator
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CoinsTableViewCell.self, forCellReuseIdentifier: CoinsTableViewCell.identifier)
        configureHeaderAction()
        
    }
    private func configureHeaderAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onNotificationTapped))
        notificationIv.addGestureRecognizer(tapGesture)
        notificationIv.isUserInteractionEnabled = true
    }
    @objc private func onNotificationTapped() {
        self.showAlert(title: "oops!", message: .localizable(.comingSoon))
    }
   @objc private func fetchData(){
        activityIndicator.startAnimating()
       self.tableView.isHidden = false
       self.noDataContainer.isHidden = true
        viewModel.fetchCoin()
    }
    
    private func bindViewModel() {
        viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                
                
                self?.tableView.reloadData()
            }
        }
        
        viewModel.onError = { [weak self] errorMsg in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.toggleErrorView(errorMsg: errorMsg ?? "", isbtnHidden: false)
            }
        }
    }
    @objc private func sortCoinsChanged(_ sender: UISegmentedControl) {
        let selectedOption = CoinSortOption.allCases[sender.selectedSegmentIndex]
        viewModel.sortOption = selectedOption
    }
    
    func toggleErrorView(errorMsg:String, isbtnHidden: Bool){
        noDataContainer.isHidden = false
        tableView.isHidden = true
        noDataContainer.noShowErrorConfig(erorMsg: errorMsg, isbtnHidden)
        noDataContainer.btnRefresh.addTarget(self, action: #selector(fetchData), for: .touchUpInside)
    }
    private func setUpConstraints(){
        view.addSubview(logoImg)
        view.addSubview(greetingLb)
        view.addSubview(notificationIv)
        view.addSubview(descLb)
       view.addSubview(sortSegmentedControl)
        view.addSubview(tableView)
        view.addSubview(noDataContainer)
        
        NSLayoutConstraint.activate([
            logoImg.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logoImg.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            logoImg.widthAnchor.constraint(equalToConstant: 60),
            logoImg.heightAnchor.constraint(equalToConstant: 60),
            
            greetingLb.centerYAnchor.constraint(equalTo: logoImg.centerYAnchor),
            greetingLb.leadingAnchor.constraint(equalTo: logoImg.trailingAnchor, constant: 8),
            
            notificationIv.centerYAnchor.constraint(equalTo: logoImg.centerYAnchor),
            notificationIv.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            notificationIv.widthAnchor.constraint(equalToConstant: 40),
            notificationIv.heightAnchor.constraint(equalToConstant: 40),
            
            descLb.topAnchor.constraint(equalTo: logoImg.bottomAnchor, constant: 8),
            descLb.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descLb.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            sortSegmentedControl.topAnchor.constraint(equalTo: descLb.bottomAnchor, constant: 8),
            sortSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            sortSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//
            
            tableView.topAnchor.constraint(equalTo: sortSegmentedControl.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            
            noDataContainer.topAnchor.constraint(equalTo: logoImg.bottomAnchor, constant: 8),
            noDataContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            noDataContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            noDataContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),

            
        ])
        
    }
}

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.coinsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoinsTableViewCell.identifier, for: indexPath) as! CoinsTableViewCell
        let model = viewModel.coin(at: indexPath.row)
        cell.configureCoinData(with: model)
        return cell
    }
    
}

extension HomeVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let threshold = viewModel.coinsCount - 1 // last row
        if indexPath.row >= threshold {
            self.fetchData()
        }else{
            activityIndicator.stopAnimating()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coin = viewModel.coin(at: indexPath.row)
        self.navigateToDetailView(coin: coin)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let coin = viewModel.coin(at: indexPath.row)
        let action = UIContextualAction(style: .normal, title: "") { [weak self] _, _, completion in
            self?.viewModel.saveFavoriteCoin(coin: coin)
            completion(true)
        }
        action.backgroundColor = UIColor.darkGreen
        action.image = .systemImage("heart.circle.fill").withTintColor(.darkGreen, renderingMode: .alwaysTemplate)

        let configuration = UISwipeActionsConfiguration(actions: [action])
        configuration.performsFirstActionWithFullSwipe = false

        return configuration
    }
    
    private func navigateToDetailView(coin: Coin){
        let swiftUIView = CoinDetailView(coin: coin)
        let hostingVc = UIHostingController(rootView: swiftUIView)
        hostingVc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(hostingVc, animated: true)
    }
}
