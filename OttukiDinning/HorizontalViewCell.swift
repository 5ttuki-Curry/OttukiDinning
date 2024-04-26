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
        restaurantImageView = networkManager.cachingImage(placeName: placeName)
        restaurantImageView.contentMode = .scaleAspectFill
    }
    
    private func setHorizontalViewCell() {
        contentView.addSubview(horizontalStackView)
        horizontalStackView.axis = .vertical
        horizontalStackView.spacing = 5
        horizontalStackView.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        horizontalStackView.isLayoutMarginsRelativeArrangement = true
        
        horizontalStackView.addArrangedSubview(restaurantImageView)
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
