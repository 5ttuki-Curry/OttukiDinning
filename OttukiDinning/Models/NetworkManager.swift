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
    
    func cachingImage(placeName: String) -> UIImageView {
        let urlString = "https://raw.githubusercontent.com/5ttuki-Curry/ImageStorage/main/\(placeName).png"
        let imageView = UIImageView()
        if let url = URL(string: urlString) {
            imageView.kf.setImage(
                with: url,
                placeholder: nil,
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
        
        return imageView
    }
    
}