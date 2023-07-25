//
//  DetailWeatherViewController.swift
//  Weather Map
//
//  Created by Hồ Bảo An on 24/07/2023.
//

import UIKit

class DetailWeatherViewController: UIViewController {
    
  
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var nameCityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageStatus: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cloudsLabel: UILabel!
    @IBOutlet weak var windyLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        updateDataDetailWeather()
    }
    
    func setUpUI() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: topView.bounds.width, height: topView.bounds.height)
        let colorLeft = UIColor(red: 0/255.0, green: 190/255.0, blue: 255/255.0, alpha: 1.0)
        let colorRight = UIColor(red: 52/255.0, green: 199/255.0, blue: 63/255.0, alpha: 1.0)
        gradientLayer.colors = [colorLeft.cgColor, colorRight.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        topView.layer.insertSublayer(gradientLayer, at: 0)
        
        topView.layer.shadowColor = UIColor.black.cgColor
        topView.layer.shadowOpacity = 1
        topView.layer.shadowOffset = CGSize.zero
        topView.layer.shadowRadius = 3
        self.view.addSubview(topView)
        
        imageStatus.layer.cornerRadius = 10
        imageStatus.clipsToBounds = true
    }

    func updateDataDetailWeather() {
   
    }

    
    
}
