//
//  Rate.swift
//  PriceCurrency
//
//  Created by Denis Dmitriev on 27.03.2023.
//

import Foundation

struct CurrencyRate: Decodable {
    
    var base: String
    var date: String
    var rates: [String: Double]
    
    enum CodingKeys: String, CodingKey {
        case base, date, rates
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.base = try container.decode(String.self, forKey: .base)
        self.date = try container.decode(String.self, forKey: .date)
        self.rates = try container.decode([String: Double].self, forKey: .rates)
    }
}
