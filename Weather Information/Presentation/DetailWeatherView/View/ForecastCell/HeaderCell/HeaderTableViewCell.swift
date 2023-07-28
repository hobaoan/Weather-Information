//
//  HeaderTableViewCell.swift
//  Weather Map
//
//  Created by Hồ Bảo An on 26/07/2023.
//

import UIKit


let kHeaderTableViewCell = "HeaderTableViewCell"
class HeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var buttonStatistic: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        buttonStatistic.layer.shadowColor = UIColor.black.cgColor
        buttonStatistic.layer.shadowOpacity = 0.6
        buttonStatistic.layer.shadowOffset = CGSize(width: 0, height: 2)
        buttonStatistic.layer.shadowRadius = 3
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

