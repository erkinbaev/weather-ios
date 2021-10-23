//
//  SearchViewModel.swift
//  weather
//
//  Created by User on 9/25/21.
//

import Foundation
import RealmSwift

protocol SearchDelegate: AnyObject {
    func showError(text: String)
    func showResult()
    func showSaveCitys() 
}

class SearchViewModel: BaseViewModel {
    
    private weak var delegate: SearchDelegate? = nil
    
    var saveCitys: Results<CityDataBaseModel>? = nil
    var result: [SearchResponseModel] = []
    
    init(delegate: SearchDelegate) {
        self.delegate = delegate
    }
    
    func saveCity(model: SearchResponseModel) {
        dataBase.saveCity(model: model.convertToDataBaseModel())
        
        delegate?.showSaveCitys()
    }
     
    func getAllCitys()  {
        saveCitys = dataBase.getAllCity()
    }
    
    func searchCity(text: String) {
        apiClient.getAutocompleteSearch(search: text) { [self] model, error in
            if let model = model {
                if model.count > 0 {
                    result = model
                    
                    delegate?.showResult()
                } else {
                    delegate?.showError(text: "Not found city")
                }
            } else {
                delegate?.showError(text: "Network not work")
            }
        }
    }
}
