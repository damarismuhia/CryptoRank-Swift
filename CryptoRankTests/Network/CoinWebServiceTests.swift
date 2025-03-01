//
//  CoinWebServiceTests.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 01/03/2025.
//


import XCTest
@testable import CryptoRank

class CoinWebServiceTests: XCTestCase {
    var sut: CoinWebService!
    var mockCoinNetworkManager: MockNetworkManagerService!
    
    override func setUp() {
        super.setUp()
        mockCoinNetworkManager = MockNetworkManagerService()
        sut = CoinWebService(networkService: mockCoinNetworkManager)
    }
    
    override func tearDown() {
        sut = nil
        mockCoinNetworkManager = nil
        super.tearDown()
    }
    
    
    func testFetchCoins_ShouldReturnSuccessResponse() {
        //MARK: - Given
        mockCoinNetworkManager.shouldReturnError = false
        mockCoinNetworkManager.mockData = MockDataProvider.mockCoinResponseJSON()
        
        let expectation = self.expectation(description: "Coin Response Returned Successfully")
        //MARK: - When
        sut.fetchCoins(offset: 0, limit: 20) { mockResponse, error in
            //MARK: - Then
            XCTAssertNotNil(mockResponse)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 1)
    }
    
    func testFetchCoins_OnApiFailure_ShouldReturnErrorMessage() {
        mockCoinNetworkManager.shouldReturnError = true
        
        let expectation = self.expectation(description: "Fetch Coins Failed")
        
        sut.fetchCoins(offset: 0, limit: 20) { mockResponse, error in
            XCTAssertNil(mockResponse)
            XCTAssertNotNil(error)
            XCTAssertEqual(error, AppError.failedRequest.errorDescription)
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 1)
    }
    
    
    
}
