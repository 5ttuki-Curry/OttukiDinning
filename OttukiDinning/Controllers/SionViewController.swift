//
//  SionViewController.swift
//  OttukiDinning
//
//  Created by t2023-m0095 on 4/22/24.
//

import UIKit
import Alamofire


class SionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate {
    
    let networkManager = NetworkManager()
    var searchDebounceTimer: Timer?
    
    var result2: [RestaurantData] = []
    let collectionView = UITableView()
    var starArray: [Double] = []
    
    @IBOutlet weak var sortingStyleButton: UIButton!
    @IBOutlet weak var listStyleButton: UIButton!
    @IBOutlet weak var collectionStyleButton: UIButton!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    
    //MARK: - 검색 스토리보드 화면
    var isCollectionMode = true
    var isListMode = false
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setStarArray()
        self.searchCollectionView.reloadData()
        
        setSearchController(searchBar)
        
        setSortingButton(sortingStyleButton)
        
        initUI()
        
        setCollectionView()
        
        setBottomUIStackView()
    }
    
    //MARK: - SearchBar
    
    // searchBar 구현
    func setSearchController( _ searchBar : UISearchBar ) {
        
        let searchController = UISearchController(searchResultsController: nil)
        // searchResultsController에는 검색결과를 표시하고싶은 ViewController 넣기
        
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = true
        self.navigationItem.title = "맛집 검색"
        searchController.hidesNavigationBarDuringPresentation = false   // 만약 위에 '맛집 검색'을 숨길거면 지워도 되는 코드
        
        searchController.searchResultsUpdater = self
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
        searchController.searchBar.placeholder = "지역, 음식, 매장명 검색"
        
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        // 검색 결과를 업데이트하는 뷰 컨트롤러로 searchController를 설정
        navigationItem.searchController = searchController
    }
    
    
    // 텍스트 검색 시
    func updateSearchResults(for searchController: UISearchController) {
        dump(searchController.searchBar.text) // 디버깅을 위한 출력
                
        guard let text = searchController.searchBar.text?.lowercased() else {
            return
        }
        
        performSearch(with: text)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // 키보드를 숨깁니다.
        
        guard let text = searchBar.text?.lowercased() else {
            return
        }
        
        performSearch(with: text)
    }
    
    func performSearch(with text: String) {
        searchDebounceTimer?.invalidate()  // 기존 타이머를 취소합니다.
        searchDebounceTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
            self?.networkManager.searchRestaurantList(keyword: text) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let a):
                        self?.result2 = a
                        self?.collectionView.reloadData()
                    case .failure(_):
                        // 에러 처리
                        break
                    }
                }
            }
            
            self?.isCollectionMode = true
            self?.setCollectionView()
        })
    }
    
    // 랜덤 별점 생성
    func setStarArray() {
        for _ in 0...15 {
            let randomRating = Double.random(in: 3.5...5.0)
            starArray.append(randomRating)
        }
    }
    
    // 별점순으로 정렬
    func setRateSorted() {
        
        let combined = zip(self.starArray, self.result2)

        // 튜플 배열을 숫자에 따라 내림차순으로 정렬합니다.
        let sortedCombined = combined.sorted(by: { $0.0 > $1.0 })

        // 정렬된 배열에서 데이터 배열과 숫자 배열을 다시 추출합니다.
        self.starArray = sortedCombined.map { $0.0 }
        self.result2 = sortedCombined.map { $0.1 }

    }

    //MARK: - CollectionView
    
    func initUI() {
        searchCollectionView.dataSource = self
        searchCollectionView.delegate = self
    }
    
    func setCollectionView() {
        searchCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: isCollectionMode ? "CollectionViewCell" : "ListCell")
        searchCollectionView.register(UINib(nibName: isCollectionMode ? "CollectionViewCell" : "ListCell", bundle: nil), forCellWithReuseIdentifier: isCollectionMode ? "CollectionViewCell" : "ListCell")
        
        self.searchCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.result2.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if isCollectionMode == true {
            guard let cell = searchCollectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.setCell(result2[indexPath.row])
            return cell
        }
        else {
            guard let cell = searchCollectionView.dequeueReusableCell(withReuseIdentifier: "ListCell", for: indexPath) as? ListCell else {
                return UICollectionViewCell()
            }
            cell.setCell(result2[indexPath.row])
            cell.ratingLabel.text = String(format: "%.1f", starArray[indexPath.row])
            
            return cell
        }
    }
    
    
    //  collectionView - view 사이즈 설정
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize(width: 160, height: 170)
        
        if isListMode == true {
            size = CGSize(width: 380, height: 100)
        }
        return size
    }
    
    
    // collectionView - 좌우 마진 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        var interval = UIEdgeInsets(top: 0, left: 25, bottom: 25, right: 25)
        
        if isListMode == true {
            interval = UIEdgeInsets(top: 0, left: 10, bottom: 20, right: 10)
        }
        
        return interval
    }
    
    
    
    //MARK: - Pop up button (정렬방식)
    
    func setSortingButton(_ button: UIButton) {
        let configuration = UIButton.Configuration.tinted()
        button.configuration = configuration
        
        
        let seletedPriority = {(action: UIAction)  in
            
            // 가나다순으로 정렬
            if action.title == "가나다 순" {
                self.result2.sort { $0.placeName < $1.placeName }
            } else {
                self.setRateSorted()
            }
            
            
            self.searchCollectionView.reloadData()
            print(action.title)}
        
        
        self.sortingStyleButton.menu = UIMenu( children: [
            UIAction(title: "오뚝 추천순", handler: seletedPriority),
            UIAction(title: "가나다 순", handler: seletedPriority),
            UIAction(title: "별점 높은 순", handler: seletedPriority)])
        self.sortingStyleButton.showsMenuAsPrimaryAction = true
        self.sortingStyleButton.changesSelectionAsPrimaryAction = true
        
    }
    
    // UICollectionViewDelegate 메소드 구현
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "DetailView", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailView") as? DetailViewController {

            detailVC.detailRestaurantData = result2[indexPath.row]
            detailVC.setRestaurantImageView(placeName: result2[indexPath.row].placeName)
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    //MARK: - IBAction
    @IBAction func tappedSortingButton(_ sender: UIButton) {
        // 정렬 방식 선택을 바꿀 때마다 변경 방식 적용
        setSortingButton(sortingStyleButton)
    }
    
    @IBAction func tappedButton(_ sender: UIButton) {
        
        // 리스트 형식으로 나타나게 하기
        isCollectionMode = false
        isListMode = true
        setCollectionView()
        
    }
    
    @IBAction func tappedCollectionStyle(_ sender: UIButton) {
        
        // 컬렉션 형식으로 나타나게 하기
        isCollectionMode = true
        isListMode = false
        setCollectionView()
    }
    
    //MARK: - 아래 버튼 구현
    
    var homeImage = UIImage(named: "HomeEmpty")
    var searchImage = UIImage(named: "Search2")
    var myInfoImage = UIImage(named: "MyInfo")
    
    var bottomUIStackView = UIStackView()
    var homeButton = UIButton()
    let searchButton = UIButton()
    let myInfoButton = UIButton()
    
    private func setBottomUIStackView() {
        view.addSubview(bottomUIStackView)
        bottomUIStackView.axis = .horizontal
        bottomUIStackView.distribution = .equalSpacing
        bottomUIStackView.isLayoutMarginsRelativeArrangement = true
        bottomUIStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 39, bottom: 0, trailing: 39)
        
        homeButton.setImage(homeImage, for: .normal)
        
        searchButton.setImage(searchImage, for: .normal)
        myInfoButton.setImage(myInfoImage, for: .normal)
        
        bottomUIStackView.addArrangedSubview(homeButton)
        bottomUIStackView.addArrangedSubview(searchButton)
        bottomUIStackView.addArrangedSubview(myInfoButton)
        
        bottomUIStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomUIStackView.heightAnchor.constraint(equalToConstant: 40),
            bottomUIStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomUIStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomUIStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        homeButton.addTarget(self, action: #selector(self.homeButtonTapped), for: .touchUpInside)
        myInfoButton.addTarget(self, action: #selector(self.myInfoButtonTapped), for: .touchUpInside)
    }
    
    @objc func homeButtonTapped() {
        ButtonManager.homeButtonTapped(viewController: self)
    }

    @objc func myInfoButtonTapped() {
        ButtonManager.myInfoButtonTapped(viewController: self)
    }
    
} // class
