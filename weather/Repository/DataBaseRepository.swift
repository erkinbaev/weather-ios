//
//  DataBaseRepository.swift
//  weather
//
//  Created by User on 9/17/21.
//

import Foundation
import RealmSwift

class DataBaseRepository {

    private static var repository = DataBaseRepository()
    
    private var dataBase: DataBase = DataBase()
    
    static func newInstanse() -> DataBaseRepository {
        return repository
    }
    
    func getAllCity() -> Results<CityDataBaseModel>? {
        return dataBase.getCityModels()
    }
    
    func saveCity(model: CityDataBaseModel) {
        dataBase.saveCityModels(model: model)
    }
}
