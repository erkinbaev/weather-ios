//
//  SearchViewModel.swift
//  weather
//
//  Created by User on 9/25/21.
//

import Foundation

protocol SearchDelegate: AnyObject {
    func showMain()
    func showError(text: String)
    func showResult(result: [SearchResponseModel])
}

class SearchViewModel: BaseViewModel {
    
    private weak var delegate: SearchDelegate? = nil
    
    init(delegate: SearchDelegate) {
        self.delegate = delegate
    }
    
    func saveCity(model: SearchResponseModel) {
        dataBase.saveCity(model: model.convertToDataBaseModel())
        
        delegate?.showMain()
    }
     
    func searchCity(text: String) {
        apiClient.getAutocompleteSearch(search: text) { [self] model, error in
            
            DispatchQueue.main.async {
                if let model = model {
                    if model.count > 0 {
                        delegate?.showResult(result: model)
                    } else {
                        delegate?.showError(text: "Not found city")
                    }
                } else {
                    delegate?.showError(text: "Network not work")
                }
            }
        }
    }
}
