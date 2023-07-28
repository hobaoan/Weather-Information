//
//  StatisticWeatherViewController.swift
//  Weather Map
//
//  Created by Hồ Bảo An on 28/07/2023.
//

import UIKit

class StatisticWeatherViewController: UIViewController {
    
    var weatherForecast: WeatherForecast?
    
    @IBOutlet weak var topView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: topView.bounds.width, height: topView.bounds.height)
        let colorLeft = UIColor(red: 66/255.0, green: 24/255.0, blue: 184/255.0, alpha: 1.0)
        let colorRight = UIColor(red: 0/255.0, green: 192/255.0, blue: 255/255.0, alpha: 1.0)
        gradientLayer.colors = [colorLeft.cgColor, colorRight.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        topView.layer.insertSublayer(gradientLayer, at: 0)
        
        topView.layer.shadowColor = UIColor.black.cgColor
        topView.layer.shadowOpacity = 1
        topView.layer.shadowOffset = CGSize.zero
        topView.layer.shadowRadius = 3
    }

}
