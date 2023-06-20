//
//  CurrencyConvrter.swift
//  PriceCurrency
//
//  Created by Denis Dmitriev on 27.03.2023.
//

import Foundation

struct CurrencyConvrter: Decodable {
    
    var query: CurrencyQuery
    var result: Double?
    
    enum CodingKeys: CodingKey {
        case query, result
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.query = try container.decode(CurrencyQuery.self, forKey: .query)
        self.result = try container.decode(Double.self, forKey: .result)
    }
}
