//
//  HomeViewController.swift
//  OttukiDinning
//
//  Created by t2023-m0056 on 4/22/24.
//

import UIKit

class HomeViewController: UICollectionViewController, UISearchResultsUpdating {
    
    var bottomUIStackView = UIStackView()
    var homeImage = UIImage(named: "Home")
    var searchImage = UIImage(named: "Search")
    var myInfoImage = UIImage(named: "MyInfo")
    var searchController: UISearchController!
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBottomUIStackView()
//        self.setCollectionView()
        self.setSearchController()
    }
    
    private func setSearchController() {
        // UISearchController 초기화 및 설정
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "검색어를 입력해주세요" // 검색창에 표시될 텍스트 설정
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        // 검색 결과 업데이트 로직 구현
        guard let searchText = searchController.searchBar.text else {
            return
        }
        
        print(searchText)
    }
    
    private func setCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomUIStackView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setBottomUIStackView() {
        view.addSubview(bottomUIStackView)
        bottomUIStackView.axis = .horizontal
        bottomUIStackView.distribution = .equalSpacing
        bottomUIStackView.isLayoutMarginsRelativeArrangement = true
        bottomUIStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 39, bottom: 0, trailing: 39)

        
        let homeButton = UIButton(type: .system)
        homeButton.setImage(homeImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        let searchButton = UIButton(type: .system)
        searchButton.setImage(searchImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        let myInfoButton = UIButton(type: .system)
        myInfoButton.setImage(myInfoImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        bottomUIStackView.addArrangedSubview(homeButton)
        bottomUIStackView.addArrangedSubview(searchButton)
        bottomUIStackView.addArrangedSubview(myInfoButton)
        
        bottomUIStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomUIStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomUIStackView.heightAnchor.constraint(equalToConstant: 40),
            bottomUIStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomUIStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
}

