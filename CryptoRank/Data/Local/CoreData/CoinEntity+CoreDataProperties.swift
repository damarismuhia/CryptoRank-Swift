//
//  CoinEntity+CoreDataProperties.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 28/02/2025.
//
//

import Foundation
import CoreData


extension CoinEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoinEntity> {
        return NSFetchRequest<CoinEntity>(entityName: "CoinEntity")
    }

    @NSManaged public var uuid: String
    @NSManaged public var name: String?
    @NSManaged public var symbol: String?
    @NSManaged public var price: String?
    @NSManaged public var btcPrice: String?
    @NSManaged public var marketCap: String?
    @NSManaged public var change: String?
    @NSManaged public var rank: String?
    @NSManaged public var sparkline: Data?
    @NSManaged public var iconUrl: String?

}

extension CoinEntity : Identifiable {

}
