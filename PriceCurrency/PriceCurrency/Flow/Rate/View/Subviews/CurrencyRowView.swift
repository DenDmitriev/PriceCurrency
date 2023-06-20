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
        HStack {
            //Text("\(currency.rate, specifier: "%.2f")")
            Text(currency.rate.formatted(.currency(code: currency.code)))
                .frame(width: 100)
            HStack(spacing: 0) {
                Text(currency.code)
                    .frame(width: 50)
                    .background(Color(uiColor: .tertiarySystemFill))
                Text(CodeDescription.description(code: currency.code))
                    .font(.caption)
                    .padding(.all, 4)
            }
            .cornerRadius(8)
            .overlay (
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(uiColor: .tertiarySystemFill), lineWidth: 2)
            )
            
        }
    }
}

struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyRowView(currency: Currency(id: 0, code: "USD", rate: 56.6))
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
