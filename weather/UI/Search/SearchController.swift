//
//  SearchController.swift
//  weather
//
//  Created by User on 9/25/21.
//

import Foundation
import UIKit
import SnapKit

class SearchController: BaseController {
    
    static func newInstanse() -> SearchController {
        return SearchController()
    }
    
    private lazy var viewModel: SearchViewModel = {
        return SearchViewModel(delegate: self)
    }()
    
    private var result: [SearchResponseModel] = []
    
    private lazy var searchField: UITextField = {
        let view = UITextField()
        view.backgroundColor = .gray
        view.delegate = self
        return view
    }()
    
    private lazy var searchResultTable: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    private lazy var searchErrorLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        view.addSubview(searchField)
        searchField.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.top.left.right.equalToSuperview()
        }
        
        view.addSubview(searchResultTable)
        searchResultTable.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(searchField.snp.bottom)
        }
        
        view.addSubview(searchErrorLabel)
        searchErrorLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
}

extension SearchController: SearchDelegate {
    func showMain() {
        navigationController?.pushViewController(MainController(), animated: true)
    }
    
    func showError(text: String) {
        searchErrorLabel.isHidden = false
        searchResultTable.isHidden = true
        
        searchErrorLabel.text = text
    }
    
    func showResult(result: [SearchResponseModel]) {
        searchErrorLabel.isHidden = true
        searchResultTable.isHidden = false
        
        self.result = result
        
        searchResultTable.reloadData()
    }
}

extension SearchController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.saveCity(model: self.result[indexPath.row])
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.result[indexPath.row]
        let cell = UITableViewCell()
        
        cell.textLabel?.text = model.localizedName
        
        return cell
    }
}

extension SearchController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel.searchCity(text: textField.text ?? String())
    }
}
