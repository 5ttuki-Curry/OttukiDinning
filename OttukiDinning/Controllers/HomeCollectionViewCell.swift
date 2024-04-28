//
//  HomeCollectionViewCell.swift
//  OttukiDinning
//
//  Created by t2023-m0056 on 4/22/24.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    let networkManager = NetworkManager()
    
    var cellNumber = 0
    let titleLabel = UILabel()
    lazy var horizontalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 139, height: 161)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "HorizontalViewCell", bundle: nil), forCellWithReuseIdentifier: "HorizontalViewCell")
        return collectionView
    }()
    weak var delegate: HomeCollectionViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.executeNetworkManager("서울 맛집")
//        self.setRestaurantData()
        self.setHomeCollectionViewCell()
        
    }
    
    func executeNetworkManager(_ keyword: String) {
        networkManager.searchRestaurantList(keyword: keyword) { [weak self] result in
            switch result {
            case .success(let restaurantList):
                NetworkManager.defaultRestaurantData = restaurantList
                self?.horizontalCollectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setHomeCollectionViewCell() {
        contentView.addSubview(titleLabel)
        titleLabel.textColor = UIColor(red: 1.0, green: 0.2627, blue: 0.2627, alpha: 1.0)
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        contentView.addSubview(horizontalCollectionView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
        
        horizontalCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            horizontalCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            horizontalCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            horizontalCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }

}

extension HomeCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalViewCell", for: indexPath) as? HorizontalViewCell else {
            return UICollectionViewCell()
        }
        // 둥근 모서리 설정
        cell.layer.cornerRadius = 12
        cell.layer.masksToBounds = true
        cell.backgroundColor = .white
        cell.layer.borderColor = UIColor(red: 1.0, green: 0.898, blue: 0, alpha: 1.0).cgColor
        cell.layer.borderWidth = 2.0
        
        switch cellNumber {
        case 0:
            cell.restaurantLabel.text = NetworkManager.seoulLivingArea[indexPath.row]
            cell.setRestaurantImageView(placeName: NetworkManager.seoulLivingArea[indexPath.row])
        case 1:
            if let restaurantData = NetworkManager.defaultRestaurantData {
                cell.restaurantLabel.text = restaurantData[indexPath.row].placeName
                cell.setRestaurantImageView(placeName: restaurantData[indexPath.row].placeName)
            } else {
                cell.restaurantLabel.text = "None"
            }
        case 2:
            if let restaurantData = NetworkManager.defaultRestaurantData {
                cell.restaurantLabel.text = restaurantData[(restaurantData.count - 1) - indexPath.row].placeName
                cell.setRestaurantImageView(placeName: restaurantData[(restaurantData.count - 1) - indexPath.row].placeName)
            } else {
                cell.restaurantLabel.text = "None"
            }
        default:
            cell.restaurantLabel.text = "None"
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItemAt(self, indexPath: indexPath)
    }
}
