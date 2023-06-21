//
//  ConverterModel.swift
//  PriceCurrency
//
//  Created by Denis Dmitriev on 29.03.2023.
//

import Foundation
import Combine

class ConverterModel: ObservableObject {
    
    @Published var error: CurrencyError? = nil
    @Published var result: Double = 0
    @Published var series: [Series] = []
    
    private var store = Set<AnyCancellable>()
    private var exchangeRateAPI: ExchangeRateAPI
    
    init() {
        self.exchangeRateAPI = ExchangeRateAPI()
    }
    
    func fetchResult(from: String, to: String, amount: Double) {
        //guard let amount = Double(amount.filter { "0123456789.".contains($0) }) else { return }
        exchangeRateAPI
            .converter(from: from, to: to, amount: amount)
            .receive(on: RunLoop.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { currencyConvrter in
                self.error = nil
                if let result = currencyConvrter.result {
                    self.result = result
                    self.saveConverterValues(from: currencyConvrter.query.from, to: currencyConvrter.query.to, amount: currencyConvrter.query.amount)
                }
            }
            .store(in: &store)

    }
    
    func fetchTimeseries(lenght: CurrencySeries.Lehght, base: String, currency: String) {
        let end = Date()
        let start = end - lenght.rawValue
        exchangeRateAPI
            .timeseries(start: start, end: end, base: base, currency: currency)
            .receive(on: RunLoop.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { currencySeries in
                self.error = nil
                self.series = currencySeries.series.sorted(by: { $0.date < $1.date })
            }
            .store(in: &store)
    }
    
    func getCurrencyQuery() -> CurrencyQuery {
        SettingsDefaults.getConverterValues() ?? CurrencyQuery(amount: 0, from: "", to: "")
    }
    
    func saveConverterValues(from: String? = nil, to: String? = nil, amount: Double? = nil) {
        SettingsDefaults.saveConverterValues(from: from, to: to, amount: amount)
    }
    
    func saveLenghtSetting(lenght: CurrencySeries.Lehght) {
        SettingsDefaults.saveLenghtSetting(lenght: lenght)
    }
    
    func getLenght() -> CurrencySeries.Lehght {
        SettingsDefaults.getLenghtSetting()
    }
}
