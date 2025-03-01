//
//  CoinDetailsViewModel.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 27/02/2025.
//

import Foundation
import CoreData



@MainActor
final class CoinDetailsViewModel: ObservableObject {
    @Published private(set) var isDetailLoading = false
    @Published private(set) var isHistoryLoading = false
    @Published private(set) var coinDetails: CoinDetailsData?
    @Published private(set) var coinHistory = [CoinHistoryData]()
    @Published var historyErrMsg: String?
    @Published var detailsErrMsg: String?
    
    let coin: Coin
    private let webService: DetailCoinWebServiceProtocol
    init(coin: Coin, webService: DetailCoinWebServiceProtocol = DetailCoinWebService()) {
        self.coin = coin
        self.webService = webService
    }

    func fetchCoinDetail() async {
        isDetailLoading = true
        defer { isDetailLoading = false }
        
        do {
            let detailResponse = try await webService.fetchCoinDetails(for: coin.uuid)
            
            if let response = detailResponse, response.status == StatusEnum.statusOk.rawValue {
                coinDetails = response.data.coin
            }else {
                self.detailsErrMsg = detailResponse?.message
            }
        }catch {
            self.detailsErrMsg = error.localizedDescription
        }
        
    }

    func fetchCoinHistory(within timePeriod: String) async {
        isHistoryLoading = true
        defer { isHistoryLoading = false }
        do {
            let historyResponse = try await webService.fetchCoinHistory(for: coin.uuid, with: timePeriod)
            if let response = historyResponse, response.status == StatusEnum.statusOk.rawValue {
                coinHistory = response.data.history
            }else {
                self.historyErrMsg = historyResponse?.message
            }
            
        }catch {
            self.historyErrMsg = error.localizedDescription
        }
    }
    
    
}
