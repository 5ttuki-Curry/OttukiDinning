//
//  NetworkManager.swift
//  OttukiDinning
//
//  Created by t2023-m0056 on 4/22/24.
//

import Foundation

class NetworkManager {
    
    func searchPlaces(keyword: String) {
        let apiKey = "4457647991508438bc027a5a8e998987" // REST API 키
        let urlString = "https://dapi.kakao.com/v2/local/search/keyword.json?query=\(keyword)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        guard let url = URL(string: urlString) else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("KakaoAK \(apiKey)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                // JSON 데이터 처리
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print(jsonResult)
                    // 필요한 정보 추출 및 사용
                }
            } catch let error {
                print("JSON 변환 실패: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
