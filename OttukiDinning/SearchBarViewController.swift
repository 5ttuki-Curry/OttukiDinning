//
//  SearchBarViewController.swift
//  OttukiDinning
//
//  Created by t2023-m0095 on 4/25/24.
//

import UIKit

class SearchBarViewController: UIViewController, UISearchBarDelegate {

    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSearchController(searchBar)
       
    }
    
    
    // searchBar 구현
    func setSearchController( _ searchBar : UISearchBar ) {
        
        let searchController = UISearchController(searchResultsController: nil)
        // searchResultsController에는 검색결과를 표시하고싶은 ViewController 넣기
        
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.title = "맛집 검색"
        searchController.hidesNavigationBarDuringPresentation = false   // 만약 위에 '맛집 검색'을 숨길거면 지워도 되는 코드
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
        searchController.searchBar.placeholder = "지역, 음식, 매장명 검색"
        
        self.searchBar.delegate = self
        self.searchBar.showsCancelButton = true
    }
    
    
    //
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
           searchBar.showsCancelButton = true
       }
       
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
           searchBar.showsCancelButton = false
       }
    
}
