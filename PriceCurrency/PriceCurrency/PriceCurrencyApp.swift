//
//  PriceCurrencyApp.swift
//  PriceCurrency
//
//  Created by Denis Dmitriev on 27.03.2023.
//

import SwiftUI

@main
struct PriceCurrencyApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView(viewModel: MainTabModel())
//            RateView(viewModel: RateModel())
//            ConverterView(viewModel: ConverterModel())
        }
    }
}
