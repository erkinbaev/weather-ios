//
//  ApiClientRepository.swift
//  weather
//
//  Created by User on 9/17/21.
//

import Foundation

class ApiClientRepository {
    
    private static var repository = ApiClientRepository()
    
    private var apiClient = ApiClient()
    
    static func newInstanse() -> ApiClientRepository {
        return repository
    }
    
    func getAutocompleteSearch(search: String, completionHandler: @escaping ([SearchResponseModel]?, String?) -> Void)  {
        apiClient.getAutocompleteSearch(search: search) { data, response, error in            
            do {
                try completionHandler(JSONDecoder().decode([SearchResponseModel].self, from: data ?? Data()), nil)
            } catch  {
                completionHandler(nil, "Data is not send")
            }
        }
    }
    
    func getFiveDaysOfDailyForecasts(cityKey: Int, completionHandler: @escaping ([SearchResponseModel]?, String?) -> Void)  {
       
    }
}
