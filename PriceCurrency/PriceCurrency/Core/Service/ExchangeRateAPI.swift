//
//  ExchangeRateAPI.swift
//  PriceCurrency
//
//  Created by Denis Dmitriev on 27.03.2023.
//

import Foundation
import Combine

struct ExchangeRateAPI {
    
    private let decoder = JSONDecoder()
    private let queue = DispatchQueue(label: "APIClient", qos: .default, attributes: .concurrent)
    
    ///Последние базовые курсы обмена, обновляемые ежедневно.
    func rates(code: String) -> AnyPublisher<CurrencyRates, CurrencyError> {
        guard let url = Method.rates(base: code).url() else {
            return Fail<CurrencyRates, CurrencyError>(error: .urlComponents)
                .eraseToAnyPublisher()
        }
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .receive(on: queue)
            .map(\.data)
            .decode(type: CurrencyRates.self, decoder: decoder)
            //.catch { _ in Empty<CurrencyRates, CurrencyError>() }
            .mapError({ error -> CurrencyError in
                switch error {
                case is URLError:
                    return CurrencyError.urlError(url: url)
                default:
                    return CurrencyError.response
                }
            })
            .eraseToAnyPublisher()
    }
    
    ///Конвертации любой суммы из одной валюты в другую.
    func converter(from: String, to: String, amount: Double) -> AnyPublisher<CurrencyConvrter, CurrencyError> {
        guard let url = Method.convert(from: from, to: to, amount: amount).url() else {
            return Fail<CurrencyConvrter, CurrencyError>(error: .urlComponents)
                .eraseToAnyPublisher()
        }
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .receive(on: queue)
            .map(\.data)
            .decode(type: CurrencyConvrter.self, decoder: decoder)
            .mapError({ error -> CurrencyError in
                switch error {
                case is URLError:
                    return CurrencyError.urlError(url: url)
                default:
                    return CurrencyError.response
                }
            })
            .eraseToAnyPublisher()
    }
    
    ///Курсы валют вплоть до 1999 года на дату.
    func rate(date: Date, from: String, to: [String], amount: Double) -> AnyPublisher<CurrencyRate, CurrencyError> {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        let toString = to.joined(separator: ",")
        guard let url = Method.rate(date: dateString, from: from, to: toString, amount: amount).url() else {
            return Fail<CurrencyRate, CurrencyError>(error: .urlComponents)
                .eraseToAnyPublisher()
        }

        return URLSession.shared
            .dataTaskPublisher(for: url)
            .receive(on: queue)
            .map(\.data)
            .decode(type: CurrencyRate.self, decoder: decoder)
            .mapError({ error -> CurrencyError in
                switch error {
                case is URLError:
                    return CurrencyError.urlError(url: url)
                default:
                    return CurrencyError.response
                }
            })
            .eraseToAnyPublisher()
    }
    
    func timeseries(start: Date, end: Date, base: String, currency: String) -> AnyPublisher<CurrencySeries, CurrencyError> {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let startString = dateFormatter.string(from: start)
        let endString = dateFormatter.string(from: end)
        guard let url = Method.timeseries(start: startString, end: endString, base: base, currency: currency).url() else {
            return Fail<CurrencySeries, CurrencyError>(error: .urlComponents)
                .eraseToAnyPublisher()
        }
        print(url)
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .receive(on: queue)
            .map(\.data)
            .decode(type: CurrencySeries.self, decoder: decoder)
            .mapError { error -> CurrencyError in
                switch error {
                case is URLError:
                    return CurrencyError.urlError(url: url)
                default:
                    return CurrencyError.response
                }
            }
            .eraseToAnyPublisher()
    }
    
    private enum Method {
        ///Последние базовые курсы обмена, обновляемые ежедневно.
        ///https://api.exchangerate.host/latest?base=rub
        case rates(base: String)
        ///Конвертации любой суммы из одной валюты в другую.
        ///https://api.exchangerate.host/convert?from=USD&to=EUR&amount=1
        case convert(from: String, to: String, amount: Double)
        ///Получить информацию о том, как валюты колеблются изо дня в день. Максимально допустимое время составляет 366 дней.
        ///https://api.exchangerate.host/fluctuation?start_date=2020-01-01&end_date=2020-01-04
        case fluctuation(startDate: String, endDate: String)
        ///Исторические курсы валют вплоть до 1999 года
        ///Вы можете запросить у API исторические курсы, добавив дату (в формате ГГГГ-ММ-ДД)
        ///https://api.exchangerate.host/2020-04-04?base=USD&symbols=RUB
        case rate(date: String, from: String, to: String, amount: Double)
        ///Ежедневная историческая ставка между двумя выбранными датами с максимальным временным интервалом 366 дней
        case timeseries(start: String, end: String, base: String, currency: String)
        
        var path: String {
            switch self {
            case .rates:
                return "/latest"
            case .convert:
                return "/convert"
            case .fluctuation:
                return "/fluctuation"
                ///ГГГГ-ММ-ДД
            case .rate(rate: let rate):
                return "/\(rate.date)"
            case .timeseries:
                return "/timeseries"
            }
        }
        
        var parameters: [String: String] {
            switch self {
            case .rates(base: let base):
                return ["base" : base]
            case .convert(from: let from, to: let to, amount: let amount):
                return ["from": from, "to": to, "amount": String(amount)]
            case .fluctuation(startDate: let startDate, endDate: let endDate):
                return ["start_date": startDate, "end_date" : endDate]
            case .rate(date: _, from: let from, to: let to, amount: let amount):
                return ["base": from, "symbols": to, "amount": String(amount)]
            case .timeseries(start: let start, end: let end, base: let base, currency: let currency):
                return ["start_date": start, "end_date": end, "base": base, "symbols": currency]
            }
        }
        
        func url() -> URL? {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.exchangerate.host"
            components.path = self.path
            components.queryItems = self.parameters.map() { URLQueryItem(name: $0, value: $1) }
            return components.url
        }
        
        
    }
}
