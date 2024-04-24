//
//  RestaurantData.swift
//  OttukiDinning
//
//  Created by t2023-m0056 on 4/22/24.
//

import Foundation

struct KakaoAPIResponse: Decodable {
    let documents: [RestaurantData]
}

struct RestaurantData: Decodable {
    let id: String
    let placeName: String    // 장소명, 업체명
    let categoryName: String    // 카테고리 이름
    let categoryGroupCode: String    // 중요 카테고리만 그룹핑한 카테고리 그룹 코드
    let categoryGroupName: String    // 중요 카테고리만 그룹핑한 카테고리 그룹명
    let phone: String    // 전화번호
    let addressName: String    // 전체 지번 주소
    let roadAddressName: String    // 전체 도로명 주소
    let x: String    // X 좌표 혹은 경도(longitude)
    let y: String    // Y 좌표 혹은 위도(latitude)
    let placeUrl: String    // 장소 상세 페이지 URL
    let distance: String    // 중심좌표까지의 거리 (단, x,y 파라미터를 준 경우에만 존재)(단위: 미터(m))
    
    enum CodingKeys: String, CodingKey {
        case id
        case placeName = "place_name"
        case categoryName = "category_name"
        case categoryGroupCode = "category_group_code"
        case categoryGroupName = "category_group_name"
        case phone
        case addressName = "address_name"
        case roadAddressName = "road_address_name"
        case x
        case y
        case placeUrl = "place_url"
        case distance
    }
}
