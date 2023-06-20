//
//  CurrencyRates.swift
//  PriceCurrency
//
//  Created by Denis Dmitriev on 27.03.2023.
//

import Foundation

struct CurrencyRates: Decodable {
    
    var base: String
    var date: String
    var rates: [Currency]
    
    private enum CodingKeys: CodingKey {
        case base, date, rates
    }
    
    private struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int?
        
        init?(intValue: Int) {
            // We are not using this, thus just return nil
            return nil
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.base = try container.decode(String.self, forKey: .base)
        self.date = try container.decode(String.self, forKey: .date)
        self.rates = []
        let containerRates = try container.nestedContainer(keyedBy: DynamicCodingKeys.self, forKey: .rates)
        for (id, key) in containerRates.allKeys.enumerated() {
            let rate = try containerRates.decode(Double.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            let currency = Currency(id: id, code: key.stringValue, rate: rate)
            self.rates.append(currency)
        }
    }

}
