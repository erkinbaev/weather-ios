//
//  MainController.swift
//  weather
//
//  Created by User on 9/17/21.
//

import Foundation
import UIKit

class MainController: BaseController {
    
    static func newInstance(cityKey: String) -> MainController {
        let viewController = MainController()
        viewController.cityKey = cityKey
        return viewController
    }
    
    private var cityKey: String? = nil
    
    override func viewDidLoad() {
        var label = UILabel()
        label.text = cityKey
        view.backgroundColor = .white

        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
}
