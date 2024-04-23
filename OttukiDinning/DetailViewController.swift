//
//  DetailViewController.swift
//  OttukiDinning
//
//  Created by t2023-m0056 on 4/23/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    var bottomUIStackView = UIStackView()
    var homeImage = UIImage(named: "Home")
    var searchImage = UIImage(named: "Search")
    var myInfoImage = UIImage(named: "MyInfo")
    var profileImage = UIImage(named: "Profile")
    
    let topMyInfoButton = UIButton()
    let homeButton = UIButton()
    let searchButton = UIButton()
    let myInfoButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBottomUIStackView()
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
            bottomUIStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomUIStackView.heightAnchor.constraint(equalToConstant: 40),
            bottomUIStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomUIStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
