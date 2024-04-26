//
//  DetailViewController.swift
//  OttukiDinning
//
//  Created by t2023-m0056 on 4/23/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    var detailRestaurantData: RestaurantData?
    let networkManager = NetworkManager()
    
    var bottomUIStackView = UIStackView()
    var middleUIStackView = UIStackView()
    var labelStackView = UIStackView()
    var homeImage = UIImage(named: "Home")
    var searchImage = UIImage(named: "Search")
    var myInfoImage = UIImage(named: "MyInfo")
    var profileImage = UIImage(named: "Profile")
    var restaurantImage = UIImage(named: "Restaurant")
    var reservationImage = UIImage(named: "Reservation")
    
    let topMyInfoButton = UIButton()
    let homeButton = UIButton()
    let searchButton = UIButton()
    let myInfoButton = UIButton()
    
    let restaurantLabel = UILabel()
    let categoryLabel = UILabel()
    let addressLabel = UILabel()
    let phoneLabel = UILabel()
    let urlLabel = UILabel()
    let reservationButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBottomUIStackView()
        self.setTopUIButton()
        self.setMiddleUIStackView()
        
    }
    
    private func setTopUIButton() {
        view.addSubview(topMyInfoButton)
        topMyInfoButton.setImage(profileImage, for: .normal)
        
        topMyInfoButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topMyInfoButton.heightAnchor.constraint(equalToConstant: 45),
            topMyInfoButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topMyInfoButton.widthAnchor.constraint(equalToConstant: 45),
            topMyInfoButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
    }
    
    private func setMiddleUIStackView() {
        view.addSubview(middleUIStackView)
        middleUIStackView.axis = .vertical
        middleUIStackView.distribution = .fillEqually
        middleUIStackView.spacing = 10
        
        let restaurantImageView = UIImageView(image: restaurantImage)
        restaurantImageView.contentMode = .scaleAspectFit
        middleUIStackView.addArrangedSubview(restaurantImageView)
        middleUIStackView.addArrangedSubview(labelStackView)
        labelStackView.axis = .vertical
        labelStackView.spacing = 10
        
        labelStackView.addArrangedSubview(restaurantLabel)
        labelStackView.addArrangedSubview(categoryLabel)
        labelStackView.addArrangedSubview(addressLabel)
        labelStackView.addArrangedSubview(phoneLabel)
        labelStackView.addArrangedSubview(urlLabel)
        labelStackView.addArrangedSubview(reservationButton)
        
        let spacerView = UIView()
        spacerView.backgroundColor = .clear
        spacerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        labelStackView.insertArrangedSubview(spacerView, at: 5)
        
        restaurantLabel.textColor = UIColor(red: 1.0, green: 0.2627, blue: 0.2627, alpha: 1.0)
        restaurantLabel.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        categoryLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        addressLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        phoneLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        urlLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        reservationButton.setImage(reservationImage, for: .normal)
        
        restaurantLabel.text = self.detailRestaurantData?.placeName
        categoryLabel.text = self.detailRestaurantData?.categoryName
        addressLabel.text = self.detailRestaurantData?.roadAddressName
        phoneLabel.text = self.detailRestaurantData?.phone
        urlLabel.text = self.detailRestaurantData?.placeUrl
        
        middleUIStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            middleUIStackView.topAnchor.constraint(equalTo: topMyInfoButton.bottomAnchor),
            middleUIStackView.bottomAnchor.constraint(equalTo: bottomUIStackView.topAnchor),
            middleUIStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            middleUIStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }
    
    private func setBottomUIStackView() {
        view.addSubview(bottomUIStackView)
        bottomUIStackView.axis = .horizontal
        bottomUIStackView.distribution = .equalSpacing
        bottomUIStackView.isLayoutMarginsRelativeArrangement = true
        bottomUIStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 39, bottom: 0, trailing: 39)
        
        bottomUIStackView.addArrangedSubview(homeButton)
        bottomUIStackView.addArrangedSubview(searchButton)
        bottomUIStackView.addArrangedSubview(myInfoButton)
        
        homeButton.setImage(homeImage, for: .normal)
        searchButton.setImage(searchImage, for: .normal)
        myInfoButton.setImage(myInfoImage, for: .normal)
        
        bottomUIStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomUIStackView.heightAnchor.constraint(equalToConstant: 100),
            bottomUIStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomUIStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomUIStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
