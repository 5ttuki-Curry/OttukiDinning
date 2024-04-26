//
//  BookingStatusTableViewCell.swift
//  OttukiDinning
//
//  Created by 박준영 on 4/25/24.
//

import UIKit

class BookingStatusTableViewCell: UITableViewCell {

    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var bookingDateLabel: UILabel!
    @IBOutlet weak var personCountLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    
    }
    
    func configureCell() {
        placeNameLabel.font = .boldSystemFont(ofSize: 23)
        
        priceLabel.textColor = UIColor(named: "PriceColor")
        priceLabel.text = "10,000원"
        
        cancelButton.layer.cornerRadius = 15
        cancelButton.backgroundColor = UIColor(named: "MainColor")
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = UIColor(named: "ShadowColor")?.cgColor
        cancelButton.setTitle("취소하기", for: .normal)
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.titleLabel?.font = .boldSystemFont(ofSize: 23)
        
        contentView.layer.cornerRadius = 15
        contentView.layer.borderWidth = 3
        contentView.layer.borderColor = UIColor(named: "ShadowColor")?.cgColor
        }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        print("취소")   // 데이터 배열 삭제하기
    }
    
}
