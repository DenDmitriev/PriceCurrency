//
//  CurrencyDescription.swift
//  PriceCurrency
//
//  Created by Denis Dmitriev on 21.03.2023.
//

import Foundation

class CodeDescription {
    
    static func description(code: String) -> String {
        return dictinary[code] ?? "Unknown currency"
    }
    
    static var codes: [String] {
        dictinary.keys.map { $0 }.sorted { $0 > $1 }
    }
    
    ///Проверка на правильность кода валюты.
    ///Возвращает код если он был верный или исправляет его на похожий
    ///Если не удалось, то выбрасывает ошибку
    static func check(code: String) throws -> String {
        if codes.contains(code) {
            return code
        } else if let correctCode = codes.filter({ $0.contains(code) }).first{
            return correctCode
        }
        throw CurrencyError.code
    }
    
    static func currencyItem(code: String) -> CurrencyItem {
        return CurrencyItem(code: code, description: description(code: code))
    }

    
    static let dictinary: [String:String] = ["XDR": "Special Drawing Rights", "MRO": "Mauritanian Ouguiya (pre-2018)", "AMD": "Armenian Dram", "KMF": "Comorian Franc", "RWF": "Rwandan Franc", "HUF": "Hungarian Forint", "TJS": "Tajikistani Somoni", "GBP": "British Pound Sterling", "MGA": "Malagasy Ariary", "ILS": "Israeli New Sheqel", "GMD": "Gambian Dalasi", "CZK": "Czech Republic Koruna", "NPR": "Nepalese Rupee", "BSD": "Bahamian Dollar", "UZS": "Uzbekistan Som", "AOA": "Angolan Kwanza", "BTN": "Bhutanese Ngultrum", "XPD": "Palladium Ounce", "RON": "Romanian Leu", "BRL": "Brazilian Real", "BGN": "Bulgarian Lev", "KRW": "South Korean Won", "TOP": "Tongan Pa\'anga", "MWK": "Malawian Kwacha", "TTD": "Trinidad and Tobago Dollar", "ANG": "Netherlands Antillean Guilder", "EGP": "Egyptian Pound", "IRR": "Iranian Rial", "NAD": "Namibian Dollar", "SVC": "Salvadoran Colón", "TRY": "Turkish Lira", "SLL": "Sierra Leonean Leone", "JPY": "Japanese Yen", "KHR": "Cambodian Riel", "SGD": "Singapore Dollar", "NGN": "Nigerian Naira", "NOK": "Norwegian Krone", "LKR": "Sri Lankan Rupee", "EUR": "Euro", "STD": "São Tomé and Príncipe Dobra (pre-2018)", "GYD": "Guyanaese Dollar", "AWG": "Aruban Florin", "MVR": "Maldivian Rufiyaa", "PAB": "Panamanian Balboa", "TND": "Tunisian Dinar", "MXN": "Mexican Peso", "SAR": "Saudi Riyal", "VUV": "Vanuatu Vatu", "KPW": "North Korean Won", "KZT": "Kazakhstani Tenge", "NIO": "Nicaraguan Córdoba", "LBP": "Lebanese Pound", "RUB": "Russian Ruble", "YER": "Yemeni Rial", "SEK": "Swedish Krona", "JMD": "Jamaican Dollar", "MOP": "Macanese Pataca", "VEF": "Venezuelan Bolívar Fuerte (Old)", "SZL": "Swazi Lilangeni", "ERN": "Eritrean Nakfa", "ALL": "Albanian Lek", "ARS": "Argentine Peso", "ISK": "Icelandic Króna", "CDF": "Congolese Franc", "NZD": "New Zealand Dollar", "LYD": "Libyan Dinar", "KGS": "Kyrgystani Som", "CNH": "Chinese Yuan (Offshore)", "PYG": "Paraguayan Guarani", "TZS": "Tanzanian Shilling", "SSP": "South Sudanese Pound", "CLF": "Chilean Unit of Account (UF)", "XPF": "CFP Franc", "PKR": "Pakistani Rupee", "JEP": "Jersey Pound", "LSL": "Lesotho Loti", "XAF": "CFA Franc BEAC", "DZD": "Algerian Dinar", "DKK": "Danish Krone", "MMK": "Myanma Kyat", "CUC": "Cuban Convertible Peso", "ETB": "Ethiopian Birr", "BYN": "Belarusian Ruble", "AUD": "Australian Dollar", "IMP": "Manx pound", "WST": "Samoan Tala", "AZN": "Azerbaijani Manat", "TMT": "Turkmenistani Manat", "SOS": "Somali Shilling", "ZMW": "Zambian Kwacha", "KES": "Kenyan Shilling", "IDR": "Indonesian Rupiah", "XPT": "Platinum Ounce", "AED": "United Arab Emirates Dirham", "BZD": "Belize Dollar", "TWD": "New Taiwan Dollar", "COP": "Colombian Peso", "BWP": "Botswanan Pula", "LAK": "Laotian Kip", "XOF": "CFA Franc BCEAO", "GEL": "Georgian Lari", "QAR": "Qatari Rial", "KYD": "Cayman Islands Dollar", "PHP": "Philippine Peso", "XAU": "Gold Ounce", "RSD": "Serbian Dinar", "UGX": "Ugandan Shilling", "BND": "Brunei Dollar", "GHS": "Ghanaian Cedi", "BMD": "Bermudan Dollar", "BHD": "Bahraini Dinar", "CUP": "Cuban Peso", "AFN": "Afghan Afghani", "XCD": "East Caribbean Dollar", "HTG": "Haitian Gourde", "GTQ": "Guatemalan Quetzal", "GNF": "Guinean Franc", "ZWL": "Zimbabwean Dollar", "MNT": "Mongolian Tugrik", "FKP": "Falkland Islands Pound", "OMR": "Omani Rial", "GIP": "Gibraltar Pound", "BTC": "Bitcoin", "PLN": "Polish Zloty", "ZAR": "South African Rand", "HNL": "Honduran Lempira", "SDG": "Sudanese Pound", "LRD": "Liberian Dollar", "BDT": "Bangladeshi Taka", "THB": "Thai Baht", "IQD": "Iraqi Dinar", "CRC": "Costa Rican Colón", "MDL": "Moldovan Leu", "JOD": "Jordanian Dinar", "PGK": "Papua New Guinean Kina", "CVE": "Cape Verdean Escudo", "UYU": "Uruguayan Peso", "MRU": "Mauritanian Ouguiya", "BOB": "Bolivian Boliviano", "STN": "São Tomé and Príncipe Dobra", "MKD": "Macedonian Denar", "GGP": "Guernsey Pound", "CLP": "Chilean Peso", "XAG": "Silver Ounce", "VES": "Venezuelan Bolívar Soberano", "BAM": "Bosnia-Herzegovina Convertible Mark", "SCR": "Seychellois Rupee", "MUR": "Mauritian Rupee", "CHF": "Swiss Franc", "MYR": "Malaysian Ringgit", "BBD": "Barbadian Dollar", "UAH": "Ukrainian Hryvnia", "INR": "Indian Rupee", "CNY": "Chinese Yuan", "SRD": "Surinamese Dollar", "MZN": "Mozambican Metical", "MAD": "Moroccan Dirham", "DOP": "Dominican Peso", "CAD": "Canadian Dollar", "USD": "United States Dollar", "DJF": "Djiboutian Franc", "FJD": "Fijian Dollar", "HKD": "Hong Kong Dollar", "PEN": "Peruvian Nuevo Sol", "VND": "Vietnamese Dong", "HRK": "Croatian Kuna", "KWD": "Kuwaiti Dinar", "SBD": "Solomon Islands Dollar", "BIF": "Burundian Franc", "SHP": "Saint Helena Pound", "SYP": "Syrian Pound"]
}
