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
    let restaurantImageView = UIImageView()
    let restaurantLabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setHorizontalViewCell()
    }
    
    func setImageView(url: String) {
        restaurantImageView.contentMode = .scaleAspectFit // 이미지 비율 유지
        
        if let url = URL(string: "\(url)1.svg") {
            restaurantImageView.kf.setImage(with: url)
        } else {
            restaurantImageView.image = UIImage(named: "Restaurant") // 이미지 이름 설정
        }
    }
    
    func cachingImage(number: String) {
        let urlString = "https://github.com/5ttuki-Curry/ImageStorage/baa18c257b05820f82b61cd03c0754b280e0bcba/\(number).svg"
        if let url = URL(string: urlString) {
            restaurantImageView.kf.setImage(
                with: url,
                placeholder: nil,
                options: [.processor(SVGProcessor())],
                completionHandler: { result in
                    switch result {
                    case .success(let value):
                        print("이미지 로드 성공: \(value.source.url?.absoluteString ?? "")")
                    case .failure(let error):
                        print("이미지 로드 실패: \(error.localizedDescription)")
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
