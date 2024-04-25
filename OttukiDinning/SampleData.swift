//
//  SampleData.swift
//  OttukiDinning
//
//  Created by t2023-m0095 on 4/24/24.
//

import Foundation
import UIKit

struct SearchStoreData{
    var name: String
    var rate : Int
    var address: String
    var image: UIImage?
}

extension SearchStoreData {
    static var data = [
        SearchStoreData(name: "lotte 롯데리아 오뚝이점", rate : 2, address: "서울시 오뚝구 버거대로 1길", image: UIImage(named: "Lotte")),
        SearchStoreData(name: "버거킹 오뚝이점", rate : 3, address: "서울시 오뚝구 버거대로 2길", image: UIImage(named: "King")),
        SearchStoreData(name: "프랭크버거 오뚝이점", rate : 4, address: "서울시 오뚝구 버거대로 3길", image: UIImage(named: "Frank")),
        SearchStoreData(name: "맥도날드 오뚝이점", rate : 4, address: "서울시 오뚝구 버거대로 4길", image: UIImage(named: "Mc")),
        SearchStoreData(name: "스파르타 오뚝이점", rate : 5, address: "서울시 오뚝구 버거대로 5길", image: UIImage(named: "Sparta"))
    ]
}
