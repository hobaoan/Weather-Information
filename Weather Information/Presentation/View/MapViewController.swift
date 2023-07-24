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
    var currentAnnotation: MKPointAnnotation?
    var tapGestureRecognizer: UITapGestureRecognizer?
    var locationName : String = ""
    
    @IBOutlet weak var inputCityTextField: UITextField!
    
    @IBOutlet weak var viewBGButton: UIView!
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        fetchWeatherData(locationName: "saigon")
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGestureRecognizer(_:)))
        view.addGestureRecognizer(tapGestureRecognizer!)
    }
    
    func fetchWeatherData(locationName: String) {
        weatherViewModel.getWeatherData(for: locationName) { error in
            DispatchQueue.main.async {
                if let error = error {
                    // Error handling
                    print("Error to fetch weather data!: \(error.localizedDescription)")
                    
                    let alertController = UIAlertController(title: "Location not found", message: "Please enter another location", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
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
            
            if let annotation = self.currentAnnotation {
                self.mapView.removeAnnotation(annotation)
            }
            
            // Set location
            let initialLocation = CLLocation(latitude: weatherData.coord.lat, longitude: weatherData.coord.lon)
            let regionRadius: CLLocationDistance = 50000
            self.centerMapOnLocation(location: initialLocation, radius: regionRadius)
            
            // Add marker
            let annotation = MKPointAnnotation()
            annotation.coordinate = initialLocation.coordinate
            self.mapView.addAnnotation(annotation)
            
            self.currentAnnotation = annotation
            
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
        
        let placeholderText = "Enter a city name"
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray,
        ]
        let attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: placeholderAttributes)
        inputCityTextField.attributedPlaceholder = attributedPlaceholder
        
        viewBGButton.layer.cornerRadius = viewBGButton.frame.width / 2
        viewBGButton.clipsToBounds = true
        viewBGButton.layer.borderColor = UIColor.black.cgColor
        viewBGButton.layer.borderWidth = 1.0
    }
    
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        // Get information from text field for search address
        if let locationName = inputCityTextField.text, !locationName.isEmpty {
            var cleanedLocationName = locationName.lowercased()
            cleanedLocationName = cleanedLocationName.replacingOccurrences(of: " ", with: "")
            cleanedLocationName = cleanedLocationName.filter { !$0.isUppercase }
            fetchWeatherData(locationName: cleanedLocationName.lowercased())
        } else {
            let alertController = UIAlertController(title: "Notification", message: "Please enter the location name", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
}

extension MapViewController {
    @objc func handleTapGestureRecognizer(_ sender: UITapGestureRecognizer) {
        // Hide the keyboard when the view is tapped
        inputCityTextField.resignFirstResponder()
    }
}
