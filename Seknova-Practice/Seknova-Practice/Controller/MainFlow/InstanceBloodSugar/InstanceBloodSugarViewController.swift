//
//  InstanceBloodSugarViewController.swift
//  Seknova-Practice
//
//  Created by 阿瑋 on 2022/12/2.
//

import Charts
import UIKit

class InstanceBloodSugarViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var chartView: LineChartView!
    @IBOutlet weak var bloodSugarIndexLabel: UILabel!
    @IBOutlet weak var bloodSugarAlert: UILabel!
    
    // MARK: - Variables
    
    var bloodSugarIndex: [Int] = []
    var bloodSugarEntry = [ChartDataEntry]()
    let date = Date()
    var dateformatter = DateFormatter()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.insertSubview(AlphaBackgroundView(imageName: "Background5.jpg", alpha: 0.2), at: 0)
        print("這是即時血糖頁面")
        
        setupUI()
        
        _ = Timer.scheduledTimer(timeInterval: 2,
                                 target: self,
                                 selector: #selector(setupChart),
                                 userInfo: nil,
                                 repeats: true)
        for i in UserPreferences.shared.lowBloodSugar...UserPreferences.shared.highBloodSugar {
            let limitLine = ChartLimitLine(limit: Double(i))
            limitLine.lineColor = .orange.withAlphaComponent(0.2)
            chartView.leftAxis.addLimitLine(limitLine)
        }
        
    }
    
    
    // MARK: - UI Settings
    
    func setupUI() {
        setupLineChartView()
    }
    
    private func setupLineChartView() {
        dateformatter.dateFormat = "HH:mm"

    }
    
    
    // MARK: - randomProduce
    
    @objc func setupChart() {
        
        let xAxisNumberFormatter = ChartXAxisFormatter()
        chartView.xAxis.valueFormatter = xAxisNumberFormatter
    
        chartView.xAxis.labelPosition = .bottom
        chartView.rightAxis.drawLabelsEnabled = false
        chartView.leftAxis.axisMinimum = 0 //最小刻度值
        chartView.leftAxis.axisMaximum = 400 //最大刻度值
    
        
        chartView.legendRenderer.legend?.form = .none
       
        
        
        let time: TimeInterval = Date().timeIntervalSince1970
        chartView.xAxis.axisMaximum = time + 3540
        chartView.xAxis.axisMinimum = time - 60
        chartView.scaleYEnabled = false
        chartView.xAxis.labelCount = 6
        chartView.autoScaleMinMaxEnabled = true
        chartView.leftAxis.drawLimitLinesBehindDataEnabled = true
        chartView.xAxis.avoidFirstLastClippingEnabled = true
        chartView.xAxis.forceLabelsEnabled = true
        chartView.rightAxis.drawGridLinesEnabled = false
        
        bloodSugarIndex.append(Int.random(in:55...400))
        bloodSugarIndexLabel.text = "\(bloodSugarIndex[bloodSugarIndex.count - 1])"
        var entry = ChartDataEntry(x: Date().timeIntervalSince1970 ,
                                   y: Double(bloodSugarIndex[bloodSugarIndex.count-1]))
        bloodSugarEntry.append(entry)
        let chartDataSet = LineChartDataSet(entries: bloodSugarEntry, label: "")
        chartDataSet.mode = .horizontalBezier
        chartDataSet.colors = [.red]
        chartDataSet.circleColors = [.red]
        chartDataSet.circleRadius = 2
        chartDataSet.drawValuesEnabled = false
        chartDataSet.drawCircleHoleEnabled = false
        chartDataSet.highlightEnabled = false
        let chartData = LineChartData(dataSets: [chartDataSet])
        chartView.data = chartData
        
    }
    
   
    // MARK: - updateAlert
    
    
    // MARK: - IBAction
    
    
}

// MARK: - Extensions



// MARK: - Protocol





