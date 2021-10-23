//
//  weatherSearchViewModelTests.swift
//  weatherTests
//
//  Created by User on 10/10/21.
//

import Foundation

import XCTest
@testable import weather

class weatherSearchViewModelTests: XCTestCase {
    
    class SearchViewModelTestsDelegeter: SearchDelegate {
        var error: String? = nil
        
        func showError(text: String) {
            error = text
        }
        
        func showResult() {
            
        }
        
        func showSaveCitys() {
            
        }
    }
    
    class ApiClientStatementMock: ApiClientStatement {
        func getAutocompleteSearch(search: String, completionHandler: @escaping ([SearchResponseModel]?, String?) -> Void) {
            let mock = SearchResponseModel()
            mock.cityKey = "222844"
            mock.localizedName = "Bishkek"
            
            if search == "Bish" {
                completionHandler([mock], nil)
            } else if search == "NotWork" {
                completionHandler(nil, nil)
            } else if search == "Case1" {
                completionHandler([], nil)
            }
        }
        
        func getFiveDaysOfDailyForecasts(cityKey: Int, completionHandler: @escaping ([SearchResponseModel]?, String?) -> Void) {
            
        }
    }
    
    func testSearchCityNotGetCitys() throws {
        let delegetor = SearchViewModelTestsDelegeter()
        
        let viewModel = SearchViewModel(delegate: delegetor)
        viewModel.apiClient = ApiClientStatementMock()
        
        viewModel.searchCity(text: "Case1")
        
        XCTAssertEqual(viewModel.result.count, 0)
        XCTAssertEqual(delegetor.error, "Not found city")
    }
    
    func testSearchCityNotWorkNetwork() throws {
        let delegetor = SearchViewModelTestsDelegeter()
        
        let viewModel = SearchViewModel(delegate: delegetor)
        viewModel.apiClient = ApiClientStatementMock()
        
        viewModel.searchCity(text: "NotWork")
        
        XCTAssertEqual(viewModel.result.count, 0)
        XCTAssertEqual(delegetor.error, "Network not work")
    }


    func testSearchCityGetCitys() throws {
        let delegetor = SearchViewModelTestsDelegeter()
        
        let viewModel = SearchViewModel(delegate: delegetor)
        viewModel.apiClient = ApiClientStatementMock()
        
        viewModel.searchCity(text: "Bish")
        
        XCTAssertEqual(viewModel.result.count, 1)
        XCTAssertEqual(viewModel.result[0].cityKey, "222844")
        XCTAssertEqual(viewModel.result[0].localizedName, "Bishkek")

    }
}
