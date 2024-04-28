//
//  NetworkManager.swift
//  OttukiDinning
//
//  Created by t2023-m0056 on 4/22/24.
//

import Alamofire
import Kingfisher
import UIKit

class NetworkManager {
    
    static var defaultRestaurantData: [RestaurantData]?
    static var seoulRestaurantData: [String: [RestaurantData]] = [:]
    static let seoulLivingArea: [String] = ["강동구 맛집", "강서구 맛집", "강북구 맛집", "강남구 맛집"]
    
    // Alamofire를 이용한 키워드 식당 리스트
    func searchRestaurantList(keyword: String, completion: @escaping (Result<[RestaurantData], Error>) -> Void) {
        let headers: HTTPHeaders = ["Authorization": "KakaoAK 4457647991508438bc027a5a8e998987"]
        let parameters: Parameters = ["query": keyword]
        let url = "https://dapi.kakao.com/v2/local/search/keyword.json"
        
        AF.request(url, method: .get, parameters: parameters, headers: headers).validate().responseDecodable(of: KakaoAPIResponse.self) { response in
            switch response.result {
            case .success(let responseData):
                completion(.success(responseData.documents))
            case .failure(let error):
                print("Error: 데이터 받아오기 실패, \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    func downloadImage(placeName: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: "https://raw.githubusercontent.com/5ttuki-Curry/ImageStorage/main/\(placeName).png") else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        KingfisherManager.shared.retrieveImage(with: url, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                // 이미지 다운로드 성공, UIImage 반환
                DispatchQueue.main.async {
                    completion(value.image)
                }
            case .failure(let error):
                // 이미지 다운로드 실패
                print("Error downloading image: \(error)")
                DispatchQueue.main.async {
                    completion(UIImage(named: "NoImage"))
                }
            }
        }
    }
    
    func setRestaurantData() {
        for keyword in NetworkManager.seoulLivingArea {
            self.searchRestaurantList(keyword: keyword) { [weak self] result in
                switch result {
                case .success(let restaurantList):
                    NetworkManager.seoulRestaurantData[keyword] = restaurantList
//                    self?.horizontalCollectionView.reloadData()
                    print(restaurantList.count)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
