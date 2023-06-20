//
//  Currency.swift
//  PriceCurrency
//
//  Created by Denis Dmitriev on 27.03.2023.
//

import Foundation

struct Currency: Decodable, Identifiable, Equatable {
    var id: Int
    var code: String
    var rate: Double
}
