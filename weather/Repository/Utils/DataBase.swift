//
//  DataBase.swift
//  weather
//
//  Created by User on 9/17/21.
//

import RealmSwift

class DataBase {
    
    private var realm: Realm? = nil
    
    init() {
        do {
            try realm = Realm()
        } catch {
            print("Error DataBase not init")
        }
    }
    
    func getCityModels() -> Results<CityDataBaseModel>? {
        return realm?.objects(CityDataBaseModel.self)
    }
    
    func deleteAllCitys() {
        do {
            try realm?.write {
                realm?.deleteAll()
            }
        } catch {
            print("Error DataBase CityDataBaseModel not all delete")
        }
    }
    
    func saveCityModels(model: CityDataBaseModel) {
        do {
            try realm?.write {
                realm?.add(model)
            }
        } catch {
            print("Error DataBase CityDataBaseModel not save")
        }
    }
}

