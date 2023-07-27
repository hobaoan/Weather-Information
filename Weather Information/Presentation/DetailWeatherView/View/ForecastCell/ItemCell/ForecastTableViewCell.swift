//
//  ForecastTableViewCell.swift
//  Weather Map
//
//  Created by Hồ Bảo An on 26/07/2023.
//

import UIKit

let kForecastTableViewCell = "ForecastTableViewCell"
class ForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageStatus: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    func setUpUI() {
        viewBackground.layer.cornerRadius = 8
        viewBackground.clipsToBounds = true
        
        viewBackground.layer.borderColor = UIColor.gray.cgColor
        viewBackground.layer.borderWidth = 1.0

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

