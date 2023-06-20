//
//  MainTabView.swift
//  PriceCurrency
//
//  Created by Denis Dmitriev on 29.03.2023.
//

import SwiftUI

struct MainTabView: View {
    
    @State private var selection: Int = 0
    
    private var viewModel: MainTabModel
    private let rateView: RateView
    private let converterView: ConverterView
    
    init(viewModel: MainTabModel) {
        self.viewModel = viewModel
        self.rateView = RateView(viewModel: RateModel())
        self.converterView = ConverterView(viewModel: ConverterModel())
    }
    
    var body: some View {
        TabView(selection: $selection) {
            rateView
                .tabItem {
                    Label("Rates", systemImage: "banknote")
                }
                .tag(0)
            converterView
                .tabItem {
                    Label("Converter", systemImage: "arrow.left.arrow.right.square")
                }
                .tag(1)
        }
        .onChange(of: selection, perform: { newValue in
            viewModel.saveTabTag(selected: newValue)
        })
        .onAppear {
            self.selection = viewModel.getTabTag()
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(viewModel: MainTabModel())
    }
}
