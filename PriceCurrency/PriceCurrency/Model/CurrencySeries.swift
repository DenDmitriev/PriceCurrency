//
//  CurrencySeries.swift
//  PriceCurrency
//
//  Created by Denis Dmitriev on 29.03.2023.
//

import Foundation

struct CurrencySeries: Decodable {

    var base: String
    var start: String
    var end: String
    var rates: [String:[String:Double]]
    
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }
    
    var series: [Series] {
        rates.compactMap { (key, value) in
            guard
                let date = dateFormatter.date(from: key),
                let rate = value.first?.value
            else { return nil }
            return Series(date: date, rate: rate)
        }
    }
    
    enum Lehght: TimeInterval, CaseIterable, CustomStringConvertible {
        
        var description: String {
            switch self {
            case .week:
                return "Week"
            case .month:
                return "Month"
            case .year:
                return "Year"
            }
        }
        
        case week = 604800
        case month = 2419200
        case year = 31536000
    }
    
    enum CodingKeys: String, CodingKey {
        case base
        case start = "start_date"
        case end = "end_date"
        case rates
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.base = try container.decode(String.self, forKey: .base)
        self.start = try container.decode(String.self, forKey: .start)
        self.end = try container.decode(String.self, forKey: .end)
        self.rates = try container.decode([String:[String:Double]].self, forKey: .rates)
    }
}
