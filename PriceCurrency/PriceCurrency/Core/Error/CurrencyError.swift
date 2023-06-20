//
//  CurrencyError.swift
//  PriceCurrency
//
//  Created by Denis Dmitriev on 27.03.2023.
//

import Foundation

enum CurrencyError: Error, Identifiable {
    
    var id: String { description }
    
    case urlComponents
    case urlError(url: URL)
    case input
    case offline
    case unknown
    case code
    case ohNo
    case response
    
    public var description: String {
        switch self {
        case .urlComponents:
            return "A URL creating from the components with error"
        case .urlError(let url):
            return "Invalid URL \(url.absoluteString)"
        case .input:
            return "Error entered currency code"
        case .offline:
            return "Internet connection is disabled"
        case .code:
            return "Invalid currency code"
        case .ohNo:
            return "Спровоцированная ошибка"
        case .response:
            return "Invalid response"
        default:
            return "Unknown error"
        }
    }
}
