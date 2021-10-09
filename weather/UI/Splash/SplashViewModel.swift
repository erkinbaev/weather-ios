//
//  SplashViewModel.swift
//  weather
//
//  Created by User on 9/17/21.
//

import Foundation

protocol SplashDelegate: AnyObject {
    func showMain()
    func showCitySearch()
}

class SplashViewModel: BaseViewModel {
    
    private weak var delegate: SplashDelegate? = nil
    
    init(delegate: SplashDelegate) {
        self.delegate = delegate
    }
    
    func navigations() {
        if dataBase.getAllCity()?.count ?? 0 > 0 {
            delegate?.showMain()
        } else {
            delegate?.showCitySearch()
        }
    }
}
