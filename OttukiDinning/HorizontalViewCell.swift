//
//  HorizontalCollectionViewCell.swift
//  OttukiDinning
//
//  Created by t2023-m0056 on 4/23/24.
//

import UIKit

class HorizontalViewCell: UICollectionViewCell {
    
    let horizontalStackView = UIStackView()
    let restaurantImage = UIImage(named: "Restaurant")
    let restaurantLabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setHorizontalViewCell()
    }
    
    private func setHorizontalViewCell() {
        contentView.addSubview(horizontalStackView)
        horizontalStackView.axis = .vertical
        
        let restaurantImageView = UIImageView(image: restaurantImage)
        horizontalStackView.addArrangedSubview(restaurantImageView)
        restaurantImageView.frame = CGRect(x: 0, y: 0, width: 117, height: 117)
        horizontalStackView.addArrangedSubview(restaurantLabel)
        restaurantLabel.textAlignment = .center
        
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalStackView.heightAnchor.constraint(equalToConstant: 161),
            horizontalStackView.topAnchor.constraint(equalTo: topAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            horizontalStackView.widthAnchor.constraint(equalToConstant: 139)
        ])
    }

}
