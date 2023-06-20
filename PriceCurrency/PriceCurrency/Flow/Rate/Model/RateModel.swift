//
//  RateModel.swift
//  PriceCurrency
//
//  Created by Denis Dmitriev on 27.03.2023.
//

import Foundation
import Combine

class RateModel: ObservableObject {
    
    @Published var currencys: [Currency]
    @Published var error: CurrencyError? = nil
    @Published var description: String
    @Published var lastUpdateTime: Date = Date()
    
    private var store = Set<AnyCancellable>()
    private var exchangeRateAPI: ExchangeRateAPI
    
    init() {
        self.currencys = []
        self.exchangeRateAPI = ExchangeRateAPI()
        self.description = ""
    }
    
    func fetchCurrencyRates(code: String) {
        exchangeRateAPI
            .rates(code: code)
            .receive(on: RunLoop.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { currencys in
                self.error = nil
                self.description = CodeDescription.description(code: currencys.base)
                self.currencys = currencys.rates.sorted { $0.code < $1.code }
                self.lastUpdateTime = Date()//.timeIntervalSince1970
            }
            .store(in: &store)
    }
    
    func getCodesTags() -> [String] {
        SettingsDefaults.getCodes() ?? []
    }
    
}
