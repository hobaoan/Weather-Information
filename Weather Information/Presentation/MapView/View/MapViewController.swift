//
//  ViewController.swift
//  Weather Information
//
//  Created by Hồ Bảo An on 19/07/2023.
//

import UIKit
import MapKit
import Reachability

class MapViewController: UIViewController {
    
    let reachability = try! Reachability()
    var isInternetAvailable = true
    
    var weatherViewModel = WeatherViewModel()
    var currentAnnotation: MKPointAnnotation?
    var tapSearchGestureRecognizer: UITapGestureRecognizer?
    var tapWeatherInforGestureRecognizer: UITapGestureRecognizer?
    var locationName : String = "saigon"
    
    @IBOutlet weak var inputCityTextField: UITextField!
    @IBOutlet weak var viewBGButton: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var imageStatus: UIImageView!
    @IBOutlet weak var viewWeatherInfor: UIView!
    
    @IBOutlet weak var nameCityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI ()
        startMonitoringReachability()
        
        tapSearchGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGestureRecognizer(_:)))
        
        tapWeatherInforGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(weatherInforTapped))
        
        
        viewWeatherInfor.addGestureRecognizer(tapWeatherInforGestureRecognizer!)
        view.addGestureRecognizer(tapSearchGestureRecognizer!)
        
        lockScreenOrientation()
    }
    
    func startMonitoringReachability() {
        reachability.whenReachable = { reachability in
            self.isInternetAvailable = true
            if reachability.connection == .wifi {
                print("Connected via WiFi")
                self.fetchWeatherData(locationName: self.locationName)
            } else if reachability.connection == .cellular {
                print("Connected via Cellular")
                self.fetchWeatherData(locationName: self.locationName)
            } else {
                print("Connected via Unknown")
                self.fetchWeatherData(locationName: self.locationName)
            }
        }
        
        reachability.whenUnreachable = { _ in
            self.isInternetAvailable = false
            print("Not connected to the internet")
            DispatchQueue.main.async {
                let alertController = UIAlertController(title: "NOT CONNECTED", message: "Please connect to the internet", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    func lockScreenOrientation() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.orientationLock = .portrait
        }
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
                    self.setUpMapWithData()
                }
            }
        }
    }
    
    func setUpMapWithData() {
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
            
            // Load image from URL
            if let icon = weatherData.weather.first?.icon {
                let imgURLString = "https://openweathermap.org/img/w/\(icon).png"
                if let imageURL = URL(string: imgURLString) {
                    let session = URLSession.shared
                    let task = session.dataTask(with: imageURL) { data, response, error in
                        if let error = error {
                            print("Error downloading image: \(error.localizedDescription)")
                        } else if let data = data, let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                self.imageStatus.image = image
                            }
                        }
                    }
                    task.resume()
                }
            }
            
            // Load name of city
            self.nameCityLabel.text = "\(weatherData.name), \(weatherData.sys.country)"
            // Load temperature
            let temperatureInt = Int(weatherData.main.temp)
            self.temperatureLabel.text = "\(temperatureInt)℃"
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
        
        viewWeatherInfor.layer.cornerRadius = 10
        viewWeatherInfor.clipsToBounds = true
        
        viewWeatherInfor.layer.borderColor = UIColor.gray.cgColor
        viewWeatherInfor.layer.borderWidth = 1.0
    }
    
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        // Get information from text field for search address
        if let locationName = inputCityTextField.text, !locationName.isEmpty {
            var cleanedLocationName = locationName.lowercased()
            cleanedLocationName = cleanedLocationName.replacingOccurrences(of: " ", with: "")
            cleanedLocationName = cleanedLocationName.filter { !$0.isUppercase }
            fetchWeatherData(locationName: cleanedLocationName.lowercased())
            self.locationName = cleanedLocationName.lowercased()
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

// Action to push DetailWeatherViewController
extension MapViewController {
    @objc func weatherInforTapped() {
        self.performSegue(withIdentifier: "pushDetailWeather", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pushDetailWeather" {
            if let destinationVC = segue.destination as? DetailWeatherViewController {
                // Pass the weatherData to the DetailWeatherViewController
                destinationVC.weatherData = weatherViewModel.weatherData
                // Pass the locationName to the DetailWeatherViewController
                destinationVC.locationName = locationName
            }
        }
    }
}
