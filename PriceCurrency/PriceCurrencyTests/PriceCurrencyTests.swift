//
//  PriceCurrencyTests.swift
//  PriceCurrencyTests
//
//  Created by Denis Dmitriev on 31.03.2023.
//

import XCTest
import Combine
@testable import PriceCurrency

final class PriceCurrencyTests: XCTestCase {
    
    var subscriptions = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        subscriptions = []
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    ///Check API method timeseries
    func testTimeseriesForWeek() {
        // Given
        guard let path = Bundle.main.path(forResource: "responseTimeseriesOfWeek", ofType: "json") else { return }
        let jsonData = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let data = try! JSONDecoder().decode(CurrencySeries.self, from: jsonData)
        let expected = data.series.count
        var result = 0
        let testViewModel = ConverterModelMock()
        let testBase = "USD"
        let testCurrency = "EUR"
        let expectation = self.expectation(description: "Timeseries")
        testViewModel.$series
            .sink { series in
                result = series.count //7+1
            }
            .store(in: &subscriptions)
        
        //When
        testViewModel.testFetchTimeseries(lenght: .week, base: testBase, currency: testCurrency) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
        
        //Then
        XCTAssert (
            expected == result,
            "👾 Expected rate count: \(expected); Expectaion rate count \(result)"
        )
    }
    
    ///Check API method rates
    func testRates() {
        // Given
        guard let path = Bundle.main.path(forResource: "responseRates", ofType: "json") else { return }
        let jsonData = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let data = try! JSONDecoder().decode(CurrencyRates.self, from: jsonData)
        let expected = data
        var result: [Currency]?
        let testViewModel = RateModelMoke()
        let testCode = "USD"
        let expectation = self.expectation(description: "Rates")
        testViewModel.$currencys
            .sink { rates in
                result = rates //7+1
            }
            .store(in: &subscriptions)
        
        //When
        testViewModel.testFetchCurrencyRates(code: testCode) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
        
        //Then
        XCTAssert (
            expected.rates.count == result?.count,
            "👾 Expected rates count: \(expected.rates.count); Expectaion rates count \(result!.count)"
        )
    }
    
    ///Check API method converter
    func testConverter() {
        //Given
        var result: Double = 0
        let from = "USD"
        let to = "RUB"
        let amount = 1.0
        let expectation = self.expectation(description: "Converter")
        let testVideoModel = ConverterModelMock()
        testVideoModel.$result
            .sink { value in
                result = value
            }
            .store(in: &subscriptions)
        
        //When
        testVideoModel.testFetchResult(from: from, to: to, amount: amount) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
        
        //Then
        XCTAssert(
            result > amount, //😩
            "👾 \(amount)$ is always more than \(result) rub"
        )

    }
    
    
}
