//
//  DetailCoinWebServiceProtocol.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 28/02/2025.
//


protocol DetailCoinWebServiceProtocol: AnyObject {
    func fetchCoinDetails(for coinId: String) async throws -> CoinDetailsResponse?
    func fetchCoinHistory(for coinId: String, with timePeriod: String) async throws -> CoinHistoryAPIResponse?
}
