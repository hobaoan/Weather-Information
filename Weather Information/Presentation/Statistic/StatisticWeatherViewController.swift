//
//  StatisticWeatherViewController.swift
//  Weather Map
//
//  Created by Hồ Bảo An on 28/07/2023.
//

import UIKit
class StatisticWeatherViewController: UIViewController, CustomSegmentedControlDelegate {
    
    var weatherForecast: WeatherForecast?
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    var currentViewController: UIViewController?
    
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: ["Temperature", "Clouds", "Humidity", "Wind"])
            interfaceSegmented.selectorViewColor = .blue
            interfaceSegmented.selectorTextColor = .blue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        interfaceSegmented.delegate = self
        showViewController(withIdentifier: "kTemperatureViewController")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func change(to index:Int) {
        print("segmentedControl index changed to \(index)")
        switch index {
        case 0:
            showViewController(withIdentifier: "kTemperatureViewController")
        case 1:
            showViewController(withIdentifier: "kCloudsViewController")
        case 2:
            showViewController(withIdentifier: "kHumidityViewController")
        case 3:
            showViewController(withIdentifier: "kWindViewController")
        default:
            break
        }
    }
    
    private func showViewController(withIdentifier identifier: String) {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: identifier) else {
            return
        }
        
        // Remove the currently displayed view controller
        currentViewController?.removeFromParent()
        currentViewController?.view.removeFromSuperview()
        
        // Add the new view controller
        addChild(viewController)
        containerView.addSubview(viewController.view)
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
        
        // Pass data to the new view controller
        configureViewController(viewController: viewController)
        
        // Update the current view controller
        currentViewController = viewController
    }
    
    
    private func configureViewController(viewController: UIViewController) {
        if let temperatureVC = viewController as? TemperatureViewController {
            temperatureVC.weatherForecast = self.weatherForecast
        } else if let cloudsVC = viewController as? CloudsViewController {
            cloudsVC.weatherForecast = self.weatherForecast
        } else if let humidityVC = viewController as? HumidityViewController {
            humidityVC.weatherForecast = self.weatherForecast
        } else if let windVC = viewController as? WindViewController {
            windVC.weatherForecast = self.weatherForecast
        }
    }
    
}
