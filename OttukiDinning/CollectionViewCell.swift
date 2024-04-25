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
    
    
    
    override var isHighlighted: Bool {
        didSet {
            guard self.isHighlighted else { return }
            
            contentView.backgroundColor = UIColor(red: 255/255, green: 247/255, blue: 176/255, alpha: 0.3)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                self.contentView.backgroundColor = .clear
            }
        }
    }
    
    func setCell(_ data: SearchStoreData){
        
        if let image = data.image {
            cellImage.image = image
        }
        
        cellLabel.text = data.name
        cellLabel.layer.masksToBounds = true
        
        
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
    
    
    
    
    
    
}
