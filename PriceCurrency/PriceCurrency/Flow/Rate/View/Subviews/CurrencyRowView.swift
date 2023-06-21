//
//  CurrencyView.swift
//  PriceCurrency
//
//  Created by Denis Dmitriev on 27.03.2023.
//

import SwiftUI

struct CurrencyRowView: View {
    
    var currency: Currency
    
    var body: some View {
        GeometryReader { reader in
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text(currency.code)
                        .padding(.horizontal, 8)
                        .font(.headline)
                    Text(CodeDescription.description(code: currency.code))
                        .font(.caption)
                        .padding(.horizontal, 8)
                }
                
                Spacer()
                
                Text(currency.rate.formatted(.currency(code: currency.code)))
                    .font(.headline)
                    .multilineTextAlignment(.trailing)
            }
            .padding(.horizontal, 16)
            .background(.clear)
        }
    }
}

struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyRowView(currency: Currency(id: 0, code: "USD", rate: 56.6))
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
