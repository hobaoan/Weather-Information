//
//  DetailWeatherViewController.swift
//  Weather Map
//
//  Created by Hồ Bảo An on 24/07/2023.
//

import UIKit

class DetailWeatherViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Add a property to hold the weather data
    var weatherData: WeatherData?
    var detailWeatherViewModel = DetailWeatherViewModel()
    var locationName: String?
    var weatherForecast: WeatherForecast?
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var nameCityLabel: UILabel!
    @IBOutlet weak var imageStatus: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cloudsLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windyLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isUserInteractionEnabled = true
        setUpUI()
        updateDataDetailWeather()
        registerTableView()
        fetchWeatherForecast(locationName: locationName ?? "")
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
        
        imageStatus.layer.cornerRadius = 10
        imageStatus.clipsToBounds = true
        imageStatus.addShadow(offset: CGSize(width: 0, height: 2), color: UIColor.black, radius: 4, opacity: 0.7)
        
    }
    
    func updateDataDetailWeather() {
        // Use the weatherData property to access the data
        if let weatherData = self.weatherData {
            // Update the UI with the weatherData values
            nameCityLabel.text = "\(weatherData.name), \(weatherData.sys.country)"
            descriptionLabel.text = weatherData.weather.first?.description
            
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
            
            let temperatureInt = Int(weatherData.main.temp)
            temperatureLabel.text = "\(temperatureInt)℃"
            cloudsLabel.text = "\(weatherData.clouds.all) %"
            humidityLabel.text = "\(weatherData.main.humidity) %"
            windyLabel.text = "\(weatherData.wind.speed) m/s"
        }
        
    }
    
    func fetchWeatherForecast(locationName: String) {
        detailWeatherViewModel.getWeatherForecast(for: locationName) { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    // Error handling
                    print("Error to fetch weather forecast!: \(error.localizedDescription)")
                } else {
                    self?.weatherForecast = self?.detailWeatherViewModel.weatherForecast
                    self?.tableView.reloadData()
                    print("Fetch weather forecast success!")
                }
            }
        }
    }
    
    func registerTableView() {
        let cellNibHeader = UINib(nibName: kHeaderTableViewCell, bundle: nil)
        tableView.register(cellNibHeader, forCellReuseIdentifier: kHeaderTableViewCell)
        let cellNibForecast = UINib(nibName: kForecastTableViewCell, bundle: nil)
        tableView.register(cellNibForecast, forCellReuseIdentifier: kForecastTableViewCell)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselect the cell with animation disabled
        tableView.deselectRow(at: indexPath, animated: false)
        // Add your code to handle the selection if needed
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherForecast?.list.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableCell(withIdentifier: kHeaderTableViewCell) as! HeaderTableViewCell
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonStatisticTapped))
        headerView.buttonStatistic.isUserInteractionEnabled = true
        headerView.buttonStatistic.addGestureRecognizer(tapGestureRecognizer)
        
        return headerView.contentView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kForecastTableViewCell, for: indexPath) as! ForecastTableViewCell
        // Make sure the weatherForecast and list are not nil
        guard let weatherForecast = self.weatherForecast,
              let forecastData = weatherForecast.list[safe: indexPath.row] else {
            return cell
        }
        
        cell.dateLabel.text = forecastData.dt_txt
        let temperatureInt = Int(forecastData.main.temp)
        cell.temperatureLabel.text = "\(temperatureInt)℃"
        cell.descriptionLabel.text = forecastData.weather.first?.description
        
        if let icon = forecastData.weather.first?.icon {
            let imgURLString = "https://openweathermap.org/img/w/\(icon).png"
            if let imageURL = URL(string: imgURLString) {
                let session = URLSession.shared
                let task = session.dataTask(with: imageURL) { data, response, error in
                    if let error = error {
                        print("Error downloading image: \(error.localizedDescription)")
                    } else if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cell.imageStatus.image = image
                        }
                    }
                }
                task.resume()
            }
        }
        
        return cell
    }
    
}
extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
extension UIView {
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
}
extension DetailWeatherViewController {
    @objc func buttonStatisticTapped() {
        performSegue(withIdentifier: "pushStatisticWeather", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pushStatisticWeather" {
            if let destinationVC = segue.destination as? StatisticWeatherViewController {
                destinationVC.weatherForecast = self.weatherForecast
            }
        }
    }
}
