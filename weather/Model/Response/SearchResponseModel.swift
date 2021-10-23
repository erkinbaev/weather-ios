//
//  SearchResponseModel.swift
//  weather
//
//  Created by User on 10/10/21.
//

import Foundation

class SearchResponseModel: Codable {
    
    var localizedName: String? = nil
    var cityKey: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case localizedName = "LocalizedName"
        case cityKey = "Key"
    }
    
    func convertToDataBaseModel() -> CityDataBaseModel {
        let model = CityDataBaseModel()
        model.cityKey = cityKey
        model.cityName = localizedName
        return model
    }
}
