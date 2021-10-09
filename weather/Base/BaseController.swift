//
//  BaseController.swift
//  weather
//
//  Created by User on 9/17/21.
//

import Foundation
import UIKit

class BaseController: UIViewController {
        
    override func viewDidLoad() {
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
