//
//  RateModelMoke.swift
//  PriceCurrencyTests
//
//  Created by Denis Dmitriev on 31.03.2023.
//

import Foundation
@testable import PriceCurrency

final class RateModelMoke: RateModel {
    func testFetchCurrencyRates(code: String, completion: @escaping (() -> Void)) {
        fetchCurrencyRates(code: code)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion()
        }
    }
}
