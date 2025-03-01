//
//  FavoriteVC.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 25/02/2025.
//
import UIKit
import CoreData
import SwiftUI
class FavoriteVC: DefaultVC {
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
    lazy var noDataContainer : NoShowView = {
        let vw = NoShowView()
        vw.btnRefresh.isHidden = false
        vw.isHidden = true
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    
    private let viewModel = CoinsViewModel()
    
    private var fetchedResultsContoller: NSFetchedResultsController<CoinEntity>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: .localizable(.favorite), style: .plain, target: nil, action: nil)
        fetchData()
    }
    
    private func setUpUI(){
        setUpConstraints()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CoinsTableViewCell.self, forCellReuseIdentifier: CoinsTableViewCell.identifier)
        
        viewModel.onFetchError = { [weak self] errorMessage in
            DispatchQueue.main.async{
                self?.toggleErrorView(errorMsg: errorMessage ?? "")
            }
        }
        
    }
    
    private func toggleTableViewOnNoDataFound(){
        guard let list = fetchedResultsContoller?.fetchedObjects else { return }
        if list.isEmpty {
            let tit: String = .localizable(.noFavorite)
            let desc: String = .localizable(.noFavoriteDesc)
            toggleErrorView(errorMsg: tit + "\n\n" + desc)
        }else {
            tableView.isHidden = false
            noDataContainer.isHidden = true
        }
    }
    func toggleErrorView(errorMsg:String){
        noDataContainer.isHidden = false
        tableView.isHidden = true
        noDataContainer.noShowErrorConfig(erorMsg: errorMsg)
        noDataContainer.btnRefresh.addTarget(self, action: #selector(fetchData), for: .touchUpInside)
    }
    @objc private func fetchData(){
        Task {
            self.fetchedResultsContoller = await viewModel.fetchFavoriteCoin()
            self.fetchedResultsContoller?.delegate = self
            DispatchQueue.main.async { [weak self] in
                self?.toggleTableViewOnNoDataFound()
                self?.tableView.reloadData()
            }
        }
    }
    
    private func setUpConstraints(){
        view.addSubview(tableView)
        view.addSubview(noDataContainer)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            
            noDataContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            noDataContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            noDataContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            noDataContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }

}
extension FavoriteVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsContoller?.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoinsTableViewCell.identifier, for: indexPath) as! CoinsTableViewCell
        if let model = fetchedResultsContoller?.object(at: indexPath){
            let coin = Coin(from: model)
            cell.configureCoinData(with: coin)
        }
        return cell
        
    }
}

extension FavoriteVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let model = fetchedResultsContoller?.object(at: indexPath){
            let coin = Coin(from: model)
            self.navigateToDetailView(coin: coin)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let coin = fetchedResultsContoller?.object(at: indexPath) else { return nil }

        let action = UIContextualAction(style: .destructive, title: "") { [weak self] _, _, completion in
            self?.viewModel.deleteFavoriteCoin(by: coin)
            self?.toggleTableViewOnNoDataFound()
            self?.tableView.reloadData()
            completion(true)
        }
        action.backgroundColor = .red
        action.image = .systemImage("trash.circle.fill").withTintColor(.white, renderingMode: .alwaysOriginal)

        let configuration = UISwipeActionsConfiguration(actions: [action])
        configuration.performsFirstActionWithFullSwipe = false

        return configuration
    }

    //Todo - remove fromhere
    private func navigateToDetailView(coin: Coin){
        let swiftUIView = CoinDetailView(coin: coin)
        let hostingVc = UIHostingController(rootView: swiftUIView)
        self.navigationController?.pushViewController(hostingVc, animated: true)
    }
}
extension FavoriteVC : NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<any NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
       case .delete:
           if let indexPath = indexPath {
               tableView.deleteRows(at: [indexPath], with: .fade)
               toggleTableViewOnNoDataFound()
           }
       case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        case .move:
           if let indexPath = indexPath, let newIndexPath = newIndexPath {
               tableView.moveRow(at: indexPath, to: newIndexPath)
           }
        default:
            return
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<any NSFetchRequestResult>, didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference) {
        
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}

