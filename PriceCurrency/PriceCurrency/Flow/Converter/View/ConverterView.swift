//
//  ConverterView.swift
//  PriceCurrency
//
//  Created by Denis Dmitriev on 29.03.2023.
//

import SwiftUI
import Charts

struct ConverterView: View {
    
    @ObservedObject var viewModel: ConverterModel
    @State private var from: String = ""
    @State private var to: String = ""
    @State private var fromDescription: String = ""
    @State private var toDescription: String = ""
    @State private var amount: Double = 0
    @State private var lenghtSeries: CurrencySeries.Lehght = .week
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Currency converter")
                .font(.headline)
            VStack {
                HStack {
                    VStack {
                        TextField("From", text: $from)
                            .font(.title)
                            .multilineTextAlignment(.center)
                            .textInputAutocapitalization(.characters)
                            .onChange(of: from) { newValue in
                                fromDescription = CodeDescription.description(code: newValue)
                                viewModel.saveConverterValues(from: newValue)
                                viewModel.fetchResult(from: newValue, to: to, amount: amount)
                                viewModel.fetchTimeseries(lenght: lenghtSeries, base: from, currency: to)
                            }
                        Text(fromDescription)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Button {
                        let from = self.from
                        self.from = self.to
                        self.to = from
                        self.amount = self.viewModel.result//.formatted()
                    } label: {
                        Image(systemName: "arrow.left.arrow.right")
                    }
                    
                    VStack {
                        TextField("To", text: $to)
                            .font(.title)
                            .multilineTextAlignment(.center)
                            .textInputAutocapitalization(.characters)
                            .onChange(of: to) { newValue in
                                toDescription = CodeDescription.description(code: newValue)
                                viewModel.saveConverterValues(to: newValue)
                                viewModel.fetchResult(from: from, to: newValue, amount: amount)
                                viewModel.fetchTimeseries(lenght: lenghtSeries, base: from, currency: to)
                            }
                        Text(toDescription)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding([.top, .leading, .trailing])
                
                Divider()
                
                VStack(spacing: 0) {
//                    TextField("Enter amount", text: $amount, formatter: .numberStyle)
                    TextField("Enter amount", value: $amount, format: .number)
                        .padding(.all)
                        .multilineTextAlignment(.center)
                        .font(.title2)
                        .keyboardType(.decimalPad)
                        .onChange(of: amount) { newValue in
                            viewModel.fetchResult(from: from, to: to, amount: newValue)
                            viewModel.fetchTimeseries(lenght: lenghtSeries, base: from, currency: to)
                        }
                    if !viewModel.result.isZero {
                        Divider()
                        HStack {
                            Spacer()
                            Text(viewModel.result.formatted(.currency(code: to)))
                                .font(.title2)
                            Spacer()
                        }
                        .padding(.all)
                        .background(Color(uiColor: .tertiarySystemFill))
                    }
                }
                
            }
            .background(.background)
            .cornerRadius(16)
            
            VStack {
                HStack(spacing: 16) {
                    Text("History rate")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Spacer()
                    ForEach(CurrencySeries.Lehght.allCases, id: \.rawValue) { lenght in
                        Button {
                            self.lenghtSeries = lenght
                            viewModel.fetchTimeseries(lenght: lenghtSeries, base: from, currency: to)
                            viewModel.saveLenghtSetting(lenght: lenght)
                        } label: {
                            Text(lenght.description)
                                .padding(.horizontal, 8)
                                .background(lenght == self.lenghtSeries ? .blue : .gray)
                                .foregroundStyle(.white)
                                .font(.footnote)
                                .cornerRadius(8)
                        }
                    }
                }
                Chart(viewModel.series, id: \.date) { series in
                    LineMark(
                        x: .value("Date", series.date),
                        y: .value("Rate", series.rate)
                    )
                }
            }
            Spacer()
        }
        .padding(.horizontal)
        .background(Color(uiColor: .quaternarySystemFill))
        .onAppear {
            let currencyQuery = viewModel.getCurrencyQuery()
            self.from = currencyQuery.from
            self.to = currencyQuery.to
            if currencyQuery.amount != 0 {
                self.amount = currencyQuery.amount//.formatted()
            }
            self.lenghtSeries = viewModel.getLenght()
            self.fromDescription = CodeDescription.description(code: from)
            self.toDescription = CodeDescription.description(code: to)
        }
        .alert(item: $viewModel.error) { error in
            Alert(title: Text("Network error"), message: Text(error.description), dismissButton: .cancel())
        }
    }
}

struct ConverterView_Previews: PreviewProvider {
    static var previews: some View {
        ConverterView(viewModel: ConverterModel())
    }
}
