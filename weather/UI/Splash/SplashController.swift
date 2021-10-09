//
//  ViewController.swift
//  weather
//
//  Created by User on 9/17/21.
//

import UIKit
import SnapKit

class SplashController: BaseController {

    private lazy var viewModel: SplashViewModel = {
        return SplashViewModel(delegate: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.navigations()
    }
}

extension SplashController: SplashDelegate {
    func showMain() {
        navigationController?.pushViewController(MainController(), animated: true)
    }
    
    func showCitySearch() {
        navigationController?.pushViewController(SearchController.newInstanse(), animated: true)
    }
}
