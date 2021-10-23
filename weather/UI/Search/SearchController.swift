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
    
    private lazy var viewModel: SearchViewModel = {
        return SearchViewModel(delegate: self)
    }()
        
    private lazy var searchField: UITextField = {
        let view = UITextField()
        view.backgroundColor = .darkGray
        view.textColor = .white
        view.attributedPlaceholder = NSAttributedString(string: "Поиск по городу", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        view.font = UIFont.systemFont(ofSize: 16)
        view.layer.cornerRadius = 8
        view.leftViewMode = .always
        
        let leftViewPadding = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 24))
        view.leftView = leftViewPadding
        view.delegate = self
        return view
    }()
    
    private lazy var searchResultTable: UITableView = {
        let view = UITableView()
        view.backgroundColor = .black
        view.separatorStyle = .none
        view.isHidden = true
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    private lazy var searchErrorLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    private lazy var titleLable: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "Погода"
        view.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return view
    }()
    
    private lazy var canselButton: UIButton = {
        let view = UIButton()
        view.isHidden = true
        view.setTitle("Отменить", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        view.addTarget(self, action: #selector(canselButtonClick), for: .touchUpInside)
        return view
    }()
    
    private lazy var saveCitysCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.backgroundColor = .black
        view.delegate = self
        view.dataSource = self
        view.register(SearchCell.self, forCellWithReuseIdentifier: "SearchCell")
        return view
    }()
    
    @objc func canselButtonClick(view: UIButton) {
        hideSearch()
    }
    
    private func hideSearch() {
        searchField.text = String()
        canselButton.isHidden = true
        searchResultTable.isHidden = true
        saveCitysCollectionView.isHidden = false
        
        searchField.snp.remakeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(titleLable.snp.bottom).offset(8)
            make.height.equalTo(32)
        }
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .black
        
        view.addSubview(titleLable)
        titleLable.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(24)
            make.left.equalToSuperview().offset(16)
        }
        
        view.addSubview(searchField)
        searchField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(titleLable.snp.bottom).offset(8)
            make.height.equalTo(32)
        }
        
        view.addSubview(canselButton)
        canselButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(titleLable.snp.bottom).offset(8)
            make.height.equalTo(32)
        }
        
        view.addSubview(searchResultTable)
        searchResultTable.snp.makeConstraints { (make) in
            make.top.equalTo(searchField.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        view.addSubview(saveCitysCollectionView)
        saveCitysCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(searchField.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
        
        viewModel.getAllCitys()
    }
}

extension SearchController: SearchDelegate {
    func showSaveCitys() {
        DispatchQueue.main.async {
            self.saveCitysCollectionView.reloadData()
        }
    }
    
    func showError(text: String) {
        
    }
    
    func showResult() {
        DispatchQueue.main.async {
            self.searchResultTable.reloadData()
        }
    }
}

extension SearchController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.saveCity(model: self.viewModel.result[indexPath.row])
        hideSearch()
        
        viewModel.getAllCitys()
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.viewModel.result[indexPath.row]
        let cell = UITableViewCell()
        
        cell.backgroundColor = .black
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = model.localizedName
        
        return cell
    }
}

extension SearchController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let text = textField.text ?? String()
        
        if text.count > 0 {
            viewModel.searchCity(text: text)
            
            canselButton.isHidden = false
            searchResultTable.isHidden = false
            saveCitysCollectionView.isHidden = true
            
            searchField.snp.remakeConstraints { (make) in
                make.left.equalToSuperview().offset(16)
                make.right.equalTo(canselButton.snp.left).offset(-16)
                make.top.equalTo(titleLable.snp.bottom).offset(8)
                make.height.equalTo(32)
            }
        } else {
            searchResultTable.isHidden = true
            canselButton.isHidden = true
            saveCitysCollectionView.isHidden = false
            
            searchField.snp.remakeConstraints { (make) in
                make.left.equalToSuperview().offset(16)
                make.right.equalToSuperview().offset(-16)
                make.top.equalTo(titleLable.snp.bottom).offset(8)
                make.height.equalTo(32)
            }
        }
    }
}

extension SearchController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 32, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = viewModel.saveCitys?[indexPath.row]
        
        if let cityKey = model?.cityKey {
            navigationController?.pushViewController(MainController.newInstance(cityKey: cityKey), animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.saveCitys?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = viewModel.saveCitys?[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as! SearchCell
        
        cell.fill(model)
        
        return cell
    }
}
