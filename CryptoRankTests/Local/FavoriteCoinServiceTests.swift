//
//  FavoriteCoinServiceTests.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 01/03/2025.
//

import XCTest
import CoreData
@testable import CryptoRank

class FavoriteCoinServiceTests: XCTestCase {
    var sut: FavoriteCoinService!
    var coredataStack: CoreDataStack!
    
    override func setUp() {
        super.setUp()
        coredataStack = CoreDataStack(modelName: "CryptoRank", inMemory: true)
        sut = FavoriteCoinService(coreDataStack: coredataStack)
    }
    
    override func tearDown() {
        coredataStack = nil
        sut = nil
        super.tearDown()
    }
}
