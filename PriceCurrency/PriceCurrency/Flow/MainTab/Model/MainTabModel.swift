//
//  MainTabModel.swift
//  PriceCurrency
//
//  Created by Denis Dmitriev on 29.03.2023.
//

import Foundation

class MainTabModel {
    
    func saveTabTag(selected: Int) {
        SettingsDefaults.saveTabTag(selected: selected)
    }
    
    func getTabTag() -> Int {
        SettingsDefaults.getTabTag()
    }
}
