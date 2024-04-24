//
//  HomeViewController.swift
//  OttukiDinning
//
//  Created by t2023-m0056 on 4/22/24.
//

import UIKit

class HomeViewController: UICollectionViewController {
    
    let networkManager = NetworkManager()
    var restaurantData: [RestaurantData] = []
    
    var bottomUIStackView = UIStackView()
    var homeImage = UIImage(named: "Home")
    var searchImage = UIImage(named: "Search")
    var myInfoImage = UIImage(named: "MyInfo")
    var profileImage = UIImage(named: "Profile")
    
    let topMyInfoButton = UIButton()
    let topSearchButton = UIButton()
    let homeButton = UIButton()
    let searchButton = UIButton()
    let myInfoButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBottomUIStackView()
        self.setTopUIButton()
        self.setCollectionView()
        view.backgroundColor = .white
        self.executeNetworkManager()
    }
    
    func executeNetworkManager() {
        networkManager.searchRestaurantList(keyword: "서울 맛집") { [weak self] result in
            switch result {
            case .success(let restaurantList):
                self?.restaurantData = restaurantList
                self?.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topSearchButton.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomUIStackView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setTopUIButton() {
        
        view.addSubview(topMyInfoButton)
        view.addSubview(topSearchButton)
        
        topMyInfoButton.setImage(profileImage, for: .normal)
        topSearchButton.setImage(searchImage, for: .normal)
        
        topMyInfoButton.translatesAutoresizingMaskIntoConstraints = false
        topSearchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topMyInfoButton.heightAnchor.constraint(equalToConstant: 45),
            topMyInfoButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topMyInfoButton.widthAnchor.constraint(equalToConstant: 45),
            topMyInfoButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            topSearchButton.heightAnchor.constraint(equalToConstant: 45),
            topSearchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topSearchButton.widthAnchor.constraint(equalToConstant: 45),
            topSearchButton.trailingAnchor.constraint(equalTo: topMyInfoButton.leadingAnchor, constant: -10)
        ])
    }
    
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
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as? HomeCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "지역별 랜덤 추천 메뉴"
        case 1:
            cell.titleLabel.text = "RISING PLACE"
        case 2:
            cell.titleLabel.text = "HOT PLACE"
        default:
            cell.titleLabel.text = "Error"
        }
        
        cell.delegate = self
        
        return cell
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    // UICollectionViewDelegateFlowLayout 메소드
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 화면의 너비
        let width = collectionView.frame.width
        // 화면의 높이를 3으로 나누어 각 섹션의 높이를 설정
        let height = collectionView.frame.height / 3
        
        return CGSize(width: width, height: height)
    }
}

extension HomeViewController: HomeCollectionViewCellDelegate {
    func didSelectItemAt(_ cell: HomeCollectionViewCell, indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "DetailView", bundle: nil)
        
        if let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailView") as? DetailViewController {
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}
