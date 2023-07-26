//
//  ItemWeatherForecast.swift
//  Weather Map
//
//  Created by Hồ Bảo An on 26/07/2023.
//

import Foundation
import UIKit

class CellWeatherForeCast {
    
    let date: String
    let temperature: Double
    let descriptionStatus: String
    let status: UIImage
    
    init(date: String, temperature: Double, descriptionStatus: String, status: UIImage) {
        self.date = date
        self.temperature = temperature
        self.descriptionStatus = descriptionStatus
        self.status = status
    }
}
