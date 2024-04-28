//
//  CollectionViewCell.swift
//  OttukiDinning
//
//  Created by t2023-m0095 on 4/24/24.
//

import UIKit
import Foundation


class CollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    
    let networkManager = NetworkManager()
    
    private var searchStore : RestaurantData? = nil {
        didSet {
            guard let searchStore = self.searchStore else {return}
            
            // 메인 페이지 상품 데이터 JSON Dummy API 활용해서 노출하기  (썸네일, 상품명, 설명, 가격)
            DispatchQueue.main.async {
                self.cellLabel.text = searchStore.placeName

            }
            
        }
    }
    
    
    override var isHighlighted: Bool {
        didSet {
            guard self.isHighlighted else { return }
            
            contentView.backgroundColor = UIColor(red: 255/255, green: 247/255, blue: 176/255, alpha: 0.3)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                self.contentView.backgroundColor = .white
            }
        }
    }
    
    
    func setCell(_ data: RestaurantData){
        
        cellLabel.text = data.placeName
        cellLabel.layer.masksToBounds = true
        
        networkManager.downloadImage(placeName: data.placeName) { image in
            // UI 작업은 메인 스레드에서 실행
            DispatchQueue.main.async {
                if let downloadedImage = image {
                    // UIImageView에 이미지 설정
                    self.cellImage.image = downloadedImage
                } else {
                    // 이미지 로딩 실패 처리
                    print("Image download failed")
                }
            }
        }
        
        // cell 테두리
        contentView.layer.cornerRadius = 16
        contentView.clipsToBounds = true
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(red: 255/255, green: 247/255, blue: 176/255, alpha: 1.0).cgColor
        
        cellShadow()
    }
    
    // cell shadow
    func cellShadow() {
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        contentView.layer.shadowRadius = 1.5
        contentView.layer.masksToBounds = false
    }
    
    //URL Session
    private func fetchRemoteProduct() {
        let storeID = Int.random(in: 1...100) // 1~1000까지 랜덤한 숫자
        
        if let url = URL(string: "https://dummyjson.com/products/\(storeID)") {
            // URLSessionDataTask를 사용하여 비동기적으로 데이터 요청
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                }
                else if let data = data {
                    
                    do {
                        let store = try JSONDecoder().decode(RestaurantData.self, from: data)
                        self.searchStore = store
                        
                        print(store.placeName)
// 이미지                       print(store.image)
                        
                    } catch {
                        print("Decode Error: \(error)")
                    }
                }
                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode)  // 보통 성공한 응답은 200번대임.
                else {return}
            }
            
            // 네트워크 요청 시작
            task.resume()
        }
    }
    
    
    
    
}
