//
//  ViewController.swift
//  Weather Information
//
//  Created by Hồ Bảo An on 19/07/2023.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var weatherViewModel = WeatherViewModel()
    var locationName : String = ""
    
    @IBOutlet weak var inputCityTextField: UITextField!
    
    @IBOutlet weak var viewBGButton: UIView!
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        fetchWeatherData(locationName: "france")
    }
    
    func fetchWeatherData(locationName: String) {
        weatherViewModel.getWeatherData(for: locationName) { error in
            DispatchQueue.main.async {
                if let error = error {
                    // Error handling
                    print("Error to fetch weather data!: \(error.localizedDescription)")
                } else {
                    // Update interface with new data
                    print("Fetch weather data success!")
                    self.weatherViewModel.printWeatherDataAsJSON()
                    self.setUpMap()
                }
            }
        }
    }
    
    func setUpMap() {
        guard let weatherData = weatherViewModel.weatherData else { return }
        DispatchQueue.main.async {
            
            // Set location
            let initialLocation = CLLocation(latitude: weatherData.coord.lat, longitude: weatherData.coord.lon)
            let regionRadius: CLLocationDistance = 50000
            self.centerMapOnLocation(location: initialLocation, radius: regionRadius)
            
            // Add marker
            let annotation = MKPointAnnotation()
            annotation.coordinate = initialLocation.coordinate
            self.mapView.addAnnotation(annotation)
            
        }
    }
    
    func centerMapOnLocation(location: CLLocation, radius: CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: radius, longitudinalMeters: radius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func setUpUI() {
        inputCityTextField.layer.cornerRadius = 15
        inputCityTextField.clipsToBounds = true
        inputCityTextField.layer.borderColor = UIColor.black.cgColor
        inputCityTextField.layer.borderWidth = 1.0
        
        viewBGButton.layer.cornerRadius = viewBGButton.frame.width / 2
        viewBGButton.clipsToBounds = true
        viewBGButton.layer.borderColor = UIColor.black.cgColor
        viewBGButton.layer.borderWidth = 1.0
    }
    
    
    
    
}

