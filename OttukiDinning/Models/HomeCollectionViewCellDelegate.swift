//
//  HomeCollectionViewCellDelegate.swift
//  OttukiDinning
//
//  Created by t2023-m0056 on 4/23/24.
//

import Foundation

protocol HomeCollectionViewCellDelegate: AnyObject {
    func didSelectItemAt(_ cell: HomeCollectionViewCell, indexPath: IndexPath)
}
