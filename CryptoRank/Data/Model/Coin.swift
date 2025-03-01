//
//  Coin.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 25/02/2025.
//

struct Coin: Codable {
    let uuid: String
    let name: String
    let symbol: String
    let price: String
    let btcPrice: String
    let marketCap: String
    let change: String
    let rank: Int
    let sparkline: [String]?
    let iconUrl: String
    
    
    init(uuid: String, name: String, symbol: String, price: String, btcPrice: String, marketCap: String, change: String, rank: Int, sparkline: [String]?, iconUrl: String) {
            self.uuid = uuid
            self.name = name
            self.symbol = symbol
            self.price = price
            self.btcPrice = btcPrice
            self.marketCap = marketCap
            self.change = change
            self.rank = rank
            self.sparkline = sparkline
            self.iconUrl = iconUrl
        }
   

    enum CodingKeys: String, CodingKey {
        case uuid, name, symbol, price, btcPrice, marketCap, change, rank, sparkline, iconUrl
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        uuid = try container.decode(String.self, forKey: .uuid)
        name = try container.decode(String.self, forKey: .name)
        symbol = try container.decode(String.self, forKey: .symbol)
        price = try container.decode(String.self, forKey: .price)
        btcPrice = try container.decode(String.self, forKey: .btcPrice)
        marketCap = try container.decode(String.self, forKey: .marketCap)
        change = try container.decode(String.self, forKey: .change)
        rank = try container.decode(Int.self, forKey: .rank)
        iconUrl = try container.decode(String.self, forKey: .iconUrl)

        let rawSparkline = try container.decodeIfPresent([String?].self, forKey: .sparkline)
        sparkline = rawSparkline?.compactMap { $0 }
    }
}

