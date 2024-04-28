//
//  HorizontalCollectionViewCell.swift
//  OttukiDinning
//
//  Created by t2023-m0056 on 4/23/24.
//

import Kingfisher
import UIKit

class HorizontalViewCell: UICollectionViewCell {
    
    let horizontalStackView = UIStackView()
    var restaurantImageView = UIImageView()
    let restaurantLabel = UILabel()
    let networkManager = NetworkManager()

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setHorizontalViewCell()
    }
    
    func setRestaurantImageView(placeName: String) {
        let urlString = "https://raw.githubusercontent.com/5ttuki-Curry/ImageStorage/main/\(placeName).png"
        
        if let url = URL(string: urlString) {
            restaurantImageView.kf.setImage(
                with: url,
                placeholder: nil,
                completionHandler: { result in
                    switch result {
                    case .success(let value):
                        print("이미지 로드 성공: \(value.source.url?.absoluteString ?? "")")
                    case .failure(let error):
                        print("이미지 로드 실패: \(error.localizedDescription)")
                        self.restaurantImageView.image = UIImage(named: "NoImage")
                    }
                }
            )
        }
    }
    
    private func setHorizontalViewCell() {
        contentView.addSubview(horizontalStackView)
        horizontalStackView.axis = .vertical
        horizontalStackView.spacing = 5
        horizontalStackView.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        horizontalStackView.isLayoutMarginsRelativeArrangement = true
        
        horizontalStackView.addArrangedSubview(restaurantImageView)
        restaurantImageView.contentMode = .scaleToFill
        restaurantImageView.widthAnchor.constraint(equalTo: restaurantImageView.heightAnchor, multiplier: 1.0).isActive = true
        restaurantImageView.layer.cornerRadius = 12
        restaurantImageView.clipsToBounds = true
        horizontalStackView.addArrangedSubview(restaurantLabel)
        restaurantLabel.textAlignment = .center
        
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: topAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            horizontalStackView.widthAnchor.constraint(equalToConstant: 139)
        ])
    }

}
