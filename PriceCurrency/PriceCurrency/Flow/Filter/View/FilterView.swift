//
//  CurrencyFilterView.swift
//  PriceCurrency
//
//  Created by Denis Dmitriev on 28.03.2023.
//

import SwiftUI

struct FilterView: View {
    
    @Binding var selectedItems: [CurrencyItem]
    @Environment(\.presentationMode) var presentingMode
    
    var viewModel = FilterModel()
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)


    var body: some View {
        VStack {
            VStack {
                HStack {
                    Button("Clear") {
                        selectedItems = []
                        SettingsDefaults.saveCodes(codes: [])
                    }
                    Spacer()
                    Button("Done") {
                        presentingMode.wrappedValue.dismiss()
                        viewModel.saveCodesTags(items: selectedItems)
                    }
                    .padding(.trailing, 16)
                }
                Text("Tags")
                    .font(.title)
                .multilineTextAlignment(.leading)
            }
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(CodeDescription.dictinary.sorted(by: { $0 < $1 }), id: \.key) { currency in
                        CurrencyItemView(items: $selectedItems, currency: CurrencyItem(code: currency.key, description: currency.value))
                    }
                }
            }
        }
        .padding(16)
    }
}

struct CurrencyFilterView_Previews: PreviewProvider {
    
    @State static var items: [CurrencyItem] = []
    
    static var previews: some View {
        FilterView(selectedItems: $items)
    }
}
