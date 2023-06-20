//
//  ConverterModelMock.swift
//  PriceCurrencyTests
//
//  Created by Denis Dmitriev on 31.03.2023.
//

import Foundation
@testable import PriceCurrency

final class ConverterModelMock: ConverterModel {
    func testFetchTimeseries(lenght: CurrencySeries.Lehght, base: String, currency: String, completion: @escaping (() -> Void)) {
        fetchTimeseries(lenght: lenght, base: base, currency: currency)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion()
        }
    }
    
    func testFetchResult(from: String, to: String, amount: Double, completion: @escaping (() -> Void)) {
        fetchResult(from: from, to: to, amount: amount)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion()
        }
    }
}
