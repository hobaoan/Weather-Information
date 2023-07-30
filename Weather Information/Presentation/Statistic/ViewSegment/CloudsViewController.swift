//
//  CloudsViewController.swift
//  Weather Map
//
//  Created by Hồ Bảo An on 30/07/2023.
//

import UIKit
import DGCharts

class CloudsViewController: UIViewController {
    
    @IBOutlet var barChartView: BarChartView!
    var weatherForecast: WeatherForecast?
    
    
    var dtTexts: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarChartView()
        customizeAxisLabels()
        
    }
    
    func setupBarChartView() {
        guard let weatherForecast = weatherForecast else {
            return
        }
        
        var entries: [BarChartDataEntry] = []
        var uniqueDtTextSet: Set<String> = [] // Step 1: Create a set to store unique dtTexts
        
        for (index, weatherInfo) in weatherForecast.list.enumerated() {
            let clouds = weatherInfo.clouds.all
            let dt_txt = String(weatherInfo.dt_txt.prefix(10))
            
            let startIndex = dt_txt.index(dt_txt.startIndex, offsetBy: 6)
            let endIndex = dt_txt.index(dt_txt.startIndex, offsetBy: 10)
            let dtText = dt_txt[startIndex..<endIndex]
            
            if !uniqueDtTextSet.contains(String(dtText)) { // Step 2: Check if dtText is not in the set
                uniqueDtTextSet.insert(String(dtText)) // Store in set
                dtTexts.append(String(dtText)) // Store in array
                
                let entry = BarChartDataEntry(x: Double(dtTexts.count - 1), y: Double(clouds)) // Step 3: Use the updated count for x-axis index
                entries.append(entry)
            }
        }
        
        let dataSet = BarChartDataSet(entries: entries, label: "Clouds")
        dataSet.colors = ChartColorTemplates.material()
        dataSet.valueTextColor = UIColor.black
        
        
        let data = BarChartData(dataSet: dataSet)
        barChartView.data = data
        
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dtTexts)
        barChartView.xAxis.granularity = 1
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.drawGridLinesEnabled = false
        
        barChartView.leftAxis.axisMinimum = 0
        barChartView.rightAxis.enabled = false
        
        barChartView.animate(yAxisDuration: 1.5)
    }
    
    func customizeAxisLabels() {
        // Font chữ đậm và size lớn
        let axisLabelFont = UIFont.boldSystemFont(ofSize: 14)
        
        // Màu chữ đen
        let axisLabelColor = UIColor.black
        
        // Customize trục OX
        barChartView.xAxis.labelFont = axisLabelFont
        barChartView.xAxis.labelTextColor = axisLabelColor
        
        // Customize trục OY
        barChartView.leftAxis.labelFont = axisLabelFont
        barChartView.leftAxis.labelTextColor = axisLabelColor
    }
    
    
}
