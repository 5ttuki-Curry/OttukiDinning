//
//  BookingHistoryTableViewCell.swift
//  OttukiDinning
//
//  Created by 박준영 on 4/25/24.
//

import UIKit

class BookingHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var bookingDateLabel: UILabel!
    @IBOutlet weak var personCountLabel: UILabel!
    
    
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
        
        bookingDateLabel.font = .boldSystemFont(ofSize: 20)
        bookingDateLabel.textColor = UIColor(named: "SubTextColor")
        
        personCountLabel.font = .boldSystemFont(ofSize: 23)
        
        contentView.layer.cornerRadius = 15
        contentView.layer.borderWidth = 3
        contentView.layer.borderColor = UIColor(named: "ShadowColor")?.cgColor
        }
    
}
