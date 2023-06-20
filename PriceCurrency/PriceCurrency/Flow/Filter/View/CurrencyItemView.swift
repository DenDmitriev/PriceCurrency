//
//  CurrencyItemView.swift
//  PriceCurrency
//
//  Created by Denis Dmitriev on 28.03.2023.
//

import SwiftUI

struct CurrencyItemView: View {
    
    @Binding var items: [CurrencyItem]
    
    var currency: CurrencyItem
    
    private var color: Color {
        items.contains(currency) ? .blue : .gray
    }
    
    var body: some View {
        Button {
            if items.contains(currency) {
                items.removeAll { $0 == currency }
            } else {
                items.append(currency)
            }
        } label: {
            VStack {
                Text(currency.code)
                    .font(.title)
                    .foregroundColor(color)
                Text(currency.description)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .foregroundColor(color)
            }
            .padding(8)
            .cornerRadius(8)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(color, lineWidth: 2)
            }
        }
    }
}

struct CurrencyItemView_Previews: PreviewProvider {
    
    static var currency = CodeDescription.dictinary.first!
    @State static var selectedItems: [CurrencyItem] = []
    
    static var previews: some View {
        CurrencyItemView(items: $selectedItems, currency: CurrencyItem(code: currency.key, description: currency.value))
            .previewLayout(.fixed(width: 200, height: 70))
    }
}
