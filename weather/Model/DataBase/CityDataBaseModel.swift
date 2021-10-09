//
//  CityDataBaseModel.swift
//  weather
//
//  Created by User on 9/25/21.
//

import RealmSwift

class CityDataBaseModel: Object {
    @objc dynamic var cityKey: String? = nil
    @objc dynamic var cityName: String? = nil
}
