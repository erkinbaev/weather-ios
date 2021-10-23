//
//  BaseViewModel.swift
//  weather
//
//  Created by User on 9/17/21.
//

import Foundation

class BaseViewModel {
    var apiClient: ApiClientStatement = ApiClientRepository.newInstanse()
    var dataBase: DataBaseStatement = DataBaseRepository.newInstanse()
}
