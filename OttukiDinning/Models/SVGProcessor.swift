//
//  SVGProcessor.swift
//  OttukiDinning
//
//  Created by t2023-m0056 on 4/25/24.
//

import Kingfisher
import SVGKit

struct SVGProcessor: ImageProcessor {
    
    let identifier = "com.yourapp.SVGProcessor"
    
    func process(item: ImageProcessItem, options: KingfisherParsedOptionsInfo) -> KFCrossPlatformImage? {
        switch item {
        case .image(let image):
            return image
        case .data(let data):
            guard let svgImage = SVGKImage(data: data) else {
                return nil
            }
            return svgImage.uiImage
        }
    }
}
