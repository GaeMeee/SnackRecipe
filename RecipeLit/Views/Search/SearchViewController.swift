//
//  SearchViewController.swift
//  RecipeLit
//
//  Created by JeonSangHyeok on 12/26/23.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    // MARK: - Properties
    var searches: [String] = [] {
        didSet {
            UserDefaults.standard.set(searches, forKey: "seartchHistory")
        }
    }
    
    // MARK: - UI Properties
    private var searchView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "검색"
        textField.delegate = self
        textField.returnKeyType = .search
        textField.backgroundColor = .clear
        return textField
    }()
    
    private var searchRightButton: UIButton = {
        let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        let image = UIImage(systemName: "magnifyingglass", withConfiguration: imageConfig)
        button.setImage(image, for: .normal)
        button.isSelected = false
        button.tintColor = .systemGray2
        return button
    }()
    
    private var recentSearchLabel: UILabel = {
        let label = UILabel()
        label.text = "최근 검색어"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var removeAllSearchesButton: UIButton = {
        let button = UIButton()
        button.setTitle("전체 삭제", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var recentSearchTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Search")
        tableView.backgroundColor = .white
        return tableView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        addTapGesture()
        getSearchHistory()
    }
}

// MARK: - Private funcs
private extension SearchViewController {
    func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    func getSearchHistory() {
        guard let saveSearches = UserDefaults.standard.stringArray(forKey: "seartchHistory") else { return }
        searches = saveSearches
    }
}

// MARK: - Actions
private extension SearchViewController {
    @objc func removeButtonTapped() {
        searches.removeAll()
        recentSearchTableView.reloadData()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func removeSearchTextFiledTapped() {
        searchTextField.text = nil
    }
}

// MARK: - AutoLayouts
private extension SearchViewController {
    func configureUI() {
        view.backgroundColor = .white
        
        configureSearchView()
        configureRecentSearchesLabel()
        configureRemoveAllSearchesButton()
        configureRecentSearchTableView()
    }
    
    func configureSearchView() {
        view.addSubview(searchView)
        
        searchView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(40)
        }
        
        configureSearchTextField()
        configureSearchRightButton()
    }
    
    func configureSearchTextField() {
        searchView.addSubview(searchTextField)
        
        searchTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview().inset(35)
            $0.height.equalTo(30)
        }
    }
    
    func configureSearchRightButton() {
        searchView.addSubview(searchRightButton)
        
        searchRightButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(4)
            $0.width.height.equalTo(28)
        }
    }
    
    func configureRecentSearchesLabel() {
        view.addSubview(recentSearchLabel)
        
        recentSearchLabel.snp.makeConstraints {
            $0.top.equalTo(searchView.snp.bottom).offset(15)
            $0.leading.equalToSuperview().inset(10)
        }
    }
    
    func configureRemoveAllSearchesButton() {
        view.addSubview(removeAllSearchesButton)
        
        removeAllSearchesButton.snp.makeConstraints {
            $0.centerY.equalTo(recentSearchLabel)
            $0.trailing.equalToSuperview().inset(15)
        }
    }
    
    func configureRecentSearchTableView() {
        view.addSubview(recentSearchTableView)
        
        recentSearchTableView.snp.makeConstraints {
            $0.top.equalTo(recentSearchLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(5)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        let noSearchLabel = UILabel(frame: CGRect(x: 0, y: 0, width: recentSearchTableView.bounds.width, height: recentSearchTableView.bounds.height))
        noSearchLabel.text = "최근 검색어 없음"
        noSearchLabel.textAlignment = .center
        noSearchLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        noSearchLabel.textColor = .systemGray4
        recentSearchTableView.backgroundView = noSearchLabel
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recentSearchTableView.backgroundView?.isHidden = searches.count != 0
        return searches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recentSearchTableView.dequeueReusableCell(withIdentifier: "Search", for: indexPath)
        cell.textLabel?.text = "\(searches[indexPath.row])"
        cell.textLabel?.textColor = .black
        cell.backgroundColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { [weak self] (_, _, completionHandler) in
            guard let self else { return }
            
            self.searches.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

// MARK: - UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        
        if let text = searchTextField.text {
            searches.append(text)
            searchTextField.text = nil
            recentSearchTableView.reloadData()
        }
        
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = searchTextField.text else { return }
        if text.count > 0 {
            let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
            let image = UIImage(systemName: "x.circle.fill", withConfiguration: imageConfig)
            searchRightButton.setImage(image, for: .normal)
            searchRightButton.tintColor = .gray
            searchRightButton.isSelected = true
            searchRightButton.addTarget(self, action: #selector(removeSearchTextFiledTapped), for: .touchUpInside)
        } else {
            let imageConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
            let image = UIImage(systemName: "magnifyingglass", withConfiguration: imageConfig)
            searchRightButton.setImage(image, for: .normal)
            searchRightButton.isSelected = false
            searchRightButton.tintColor = .systemGray2
        }
    }
}
