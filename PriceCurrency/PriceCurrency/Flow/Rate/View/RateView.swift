//
//  RateView.swift
//  PriceCurrency
//
//  Created by Denis Dmitriev on 27.03.2023.
//

import SwiftUI

struct RateView: View {
    
    @State private var code: String = "USD"
    @State private var showingFilter = false
    @ObservedObject var viewModel: RateModel
    @State private var selectedItems: [CurrencyItem] = []
    @State private var currentDate: Date = Date()
    
    private var timer = Timer.publish(every: 5, on: .main, in: .common)
        .autoconnect()
        .eraseToAnyPublisher()
    private var dateFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = [.default]
        return formatter
    }()
    
    init(viewModel: RateModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Currency rate")
                .font(.headline)
            VStack {
                TextField("Code currency", text: $code)
                    .padding(.top)
                    .autocapitalization(.allCharacters)
                    .font(.title)
                    .textInputAutocapitalization(.characters)
                    .multilineTextAlignment(.center)
                    .onChange(of: code) { newCode in
                        viewModel.fetchCurrencyRates(code: newCode)
                    }
                Text(viewModel.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.bottom)
                
            }
            .background(.background)
            .cornerRadius(16)
            .padding(.all)
            
            HStack(alignment: .bottom) {
                Text("lust update \(dateFormatter.string(from: viewModel.lastUpdateTime, to: currentDate) ?? Date().formatted()) ago")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .onReceive(timer) { date in
                        self.currentDate = date
                    }
                    .padding()
                Spacer()
                Button {
                    showingFilter.toggle()
                } label: {
                    Text("Filter")
                        .padding(.horizontal, 8)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .font(.footnote)
                        .cornerRadius(8)
                }
                .padding()
                .popover(isPresented: $showingFilter) {
                    FilterView(selectedItems: $selectedItems)
                }
            }
//            .background(.background)
            .cornerRadius(16)
            .padding(.horizontal)
            
            List(viewModel.currencys) { currency in
                if selectedItems.isEmpty {
                    CurrencyRowView(currency: currency)
                        .listRowSeparator(.hidden)
                } else {
                    if selectedItems.contains(where: { $0.code == currency.code }) {
                        CurrencyRowView(currency: currency)
                            .listRowSeparator(.hidden)
                    }
                }
            }
            .listStyle(.insetGrouped)
        }
        .background(Color(uiColor: .quaternarySystemFill))
        .onAppear() {
            viewModel.fetchCurrencyRates(code: code)
            let currencyItems = viewModel.getCodesTags().map { code in
                CurrencyItem(
                    code: code,
                    description: CodeDescription.description(code: code))
            }
            selectedItems = currencyItems
        }
        .alert(item: $viewModel.error) { error in
            Alert(title: Text("Network error"), message: Text(error.description), dismissButton: .cancel())
        }
    }
}

struct RateView_Previews: PreviewProvider {
    static var previews: some View {
        RateView(viewModel: RateModel())
    }
}
