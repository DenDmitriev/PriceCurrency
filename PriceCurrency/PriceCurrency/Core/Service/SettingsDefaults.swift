//
//  UserDefaultsService.swift
//  PriceCurrency
//
//  Created by Denis Dmitriev on 29.03.2023.
//

import Foundation

class SettingsDefaults {
    
    private static let standard = UserDefaults.standard
    
    private enum Keys: String {
        case tab
        case codes
        case lenght
        case from
        case to
        case amount
    }
    
    static func getCodes() -> [String]? {
        standard.stringArray(forKey: Keys.codes.rawValue)
    }
    
    static func saveCodes(codes: [String]) {
        standard.set(codes, forKey: Keys.codes.rawValue)
    }
    
    static func saveLenghtSetting(lenght: CurrencySeries.Lehght) {
        standard.set(lenght.rawValue, forKey: Keys.lenght.rawValue)
    }
    
    static func getLenghtSetting() -> CurrencySeries.Lehght {
        let timeinterval: TimeInterval = standard.double(forKey: Keys.lenght.rawValue)
        return CurrencySeries.Lehght(rawValue: timeinterval) ?? .week
    }
    
    static func saveConverterValues(from: String? = nil, to: String? = nil, amount: Double? = nil) {
        if let from = from {
            standard.set(from, forKey: Keys.from.rawValue)
        }
        
        if let to = to {
            standard.set(to, forKey: Keys.to.rawValue)
        }
        
        if let amount = amount {
            standard.set(amount, forKey: Keys.amount.rawValue)
        }
        
    }
    
    static func getConverterValues() -> CurrencyQuery? {
        guard
            let from = standard.string(forKey: Keys.from.rawValue),
            let to = standard.string(forKey: Keys.to.rawValue)
        else {
            return nil
        }
        let amount = standard.double(forKey: Keys.amount.rawValue)
        
        return CurrencyQuery(amount: amount, from: from, to: to)
    }
    
    static func saveTabTag(selected: Int) {
        standard.set(selected, forKey: Keys.tab.rawValue)
    }
    
    static func getTabTag() -> Int {
        standard.integer(forKey: Keys.tab.rawValue)
    }
}
