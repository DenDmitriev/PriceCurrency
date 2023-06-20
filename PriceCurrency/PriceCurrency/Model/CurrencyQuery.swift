//
//  CurrencyQuery.swift
//  PriceCurrency
//
//  Created by Denis Dmitriev on 27.03.2023.
//

import Foundation

struct CurrencyQuery: Decodable {
    var amount: Double
    var from: String
    var to: String
    
    enum CodingKeys: CodingKey {
        case amount, from, to
    }
    
    init(amount: Double, from: String, to: String) {
        self.amount = amount
        self.from = from
        self.to = to
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.amount = try container.decode(Double.self, forKey: .amount)
        self.from = try container.decode(String.self, forKey: .from)
        self.to = try container.decode(String.self, forKey: .to)
    }
}
