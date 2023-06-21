//
//  FilterModel.swift
//  PriceCurrency
//
//  Created by Denis Dmitriev on 31.03.2023.
//

import Foundation

class FilterModel {
    func saveCodesTags(items: [CurrencyItem] ) {
        SettingsDefaults.saveCodes(codes: items.map { $0.code })
    }
}
