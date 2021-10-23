//
//  DataBaseRepository.swift
//  weather
//
//  Created by User on 9/17/21.
//

import Foundation
import RealmSwift

class DataBaseRepository: DataBaseStatement {

    private static var repository = DataBaseRepository()
    
    private var dataBase: DataBase = DataBase()
    
    static func newInstanse() -> DataBaseRepository {
        return repository
    }
    
    func deleteAllCitys() {
        dataBase.deleteAllCitys()
    }
    
    func getAllCity() -> Results<CityDataBaseModel>? {
        return dataBase.getCityModels()
    }
    
    func saveCity(model: CityDataBaseModel) {
        dataBase.saveCityModels(model: model)
    }
}

protocol DataBaseStatement {
    func deleteAllCitys()
    func getAllCity() -> Results<CityDataBaseModel>?
    func saveCity(model: CityDataBaseModel)
}
