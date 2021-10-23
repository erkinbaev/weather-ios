//
//  SearchCell.swift
//  weather
//
//  Created by User on 10/10/21.
//

import Foundation
import UIKit
import SnapKit

class SearchCell: UICollectionViewCell {
    
    private lazy var title: UILabel = {
        let view = UILabel()
        view.textColor = .black
        return view
    }()
    
    override func layoutSubviews() {
        backgroundColor = .white
        layer.cornerRadius = 16
        
        addSubview(title)
        title.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
    }
    
    func fill(_ model: CityDataBaseModel?) {
        title.text = model?.cityName
    }
    
}
