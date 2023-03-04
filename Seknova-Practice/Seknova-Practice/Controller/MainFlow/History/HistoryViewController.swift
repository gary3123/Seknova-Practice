//
//  HistoryViewController.swift
//  Seknova-Practice
//
//  Created by 阿瑋 on 2022/12/2.
//
import RealmSwift
import Charts
import UIKit

class HistoryViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var enlargeButton: UIButton!
    @IBOutlet weak var chartView: LineChartView!
    @IBOutlet weak var TimeSegmentControl: UISegmentedControl!
    
    // MARK: - Variables
    enum TimeWidth {
        case oneHr
        case threeHr
        case sixHr
        case twelveHr
        case twentyFourHr
    }
    
    var timeWidth: TimeWidth = .oneHr
    var bloodSugarIndex: [Int] = []
    let xAxisNumberFormatter = ChartXAxisFormatter()
    var bloodSugarEntry = [ChartDataEntry]()
    let realm = try! Realm()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(randonProduce), userInfo: nil, repeats: true)
        setupUI()
    }
    
    
    // MARK: - UI Settings
    func setupUI() {
        setChartView()
    }
    
    func setChartView() {
        let eventDataTable = realm.objects(EventData.self)
        let dateTimeFormatter = DateFormatter()
        dateTimeFormatter.dateFormat = "yyyy/MM/dd EEEE a hh:mm"
        dateTimeFormatter.locale = Locale(identifier: "zh_TW")
        
        xAxisNumberFormatter.whichPageToUse = .history
        chartView.xAxis.valueFormatter = xAxisNumberFormatter
        chartView.rightAxis.drawLabelsEnabled = false
        chartView.leftAxis.axisMinimum = 0 //最小刻度值
        chartView.leftAxis.axisMaximum = 400 //最大刻度值
        chartView.xAxis.labelPosition = .bottom
        
        chartView.legendRenderer.legend?.form = .none
        
        let time: TimeInterval = Date().timeIntervalSince1970
        chartView.xAxis.axisMaximum = time
        
        switch timeWidth {
        case .oneHr:
            chartView.xAxis.axisMinimum = time - 3600
        case .threeHr:
            chartView.xAxis.axisMaximum = time
            chartView.xAxis.axisMinimum = time - 3600 * 3
        case .sixHr:
            chartView.xAxis.axisMinimum = time - 3600 * 6
        case .twelveHr:
            chartView.xAxis.axisMinimum = time - 3600 * 12
        default:
            chartView.xAxis.axisMinimum = time - 3600 * 24
        }
        

        chartView.scaleYEnabled = false
        chartView.xAxis.labelFont = UIFont(name: "Helvetica", size: 7)!
        chartView.xAxis.labelCount = 6
        chartView.autoScaleMinMaxEnabled = true
        chartView.leftAxis.drawLimitLinesBehindDataEnabled = true
        chartView.xAxis.avoidFirstLastClippingEnabled = true
        chartView.xAxis.forceLabelsEnabled = true
        chartView.rightAxis.drawGridLinesEnabled = false
        
        
        if bloodSugarIndex.count != 0 {
            var entry = ChartDataEntry(x: Date().timeIntervalSince1970,
                                       y: Double(bloodSugarIndex[bloodSugarIndex.count - 1]))
            bloodSugarEntry.append(entry)
        }
        
        let instanceBloodChartDataSet = LineChartDataSet(entries: bloodSugarEntry, label: "")
        instanceBloodChartDataSet.mode = .horizontalBezier
        instanceBloodChartDataSet.colors = [.red]
        instanceBloodChartDataSet.circleColors = [.red]
        instanceBloodChartDataSet.circleRadius = 2
        instanceBloodChartDataSet.drawValuesEnabled = false
        instanceBloodChartDataSet.drawCircleHoleEnabled = false
        instanceBloodChartDataSet.highlightEnabled = false
        let chartData = LineChartData(dataSets: [instanceBloodChartDataSet])
        chartView.data = chartData
        
        //=========================================
        var eventValueEntry = ChartDataEntry()
        let image = UIImage(named: "edit")
        for i in 0 ..< eventDataTable.count {
            image?.draw(in: CGRect(x: dateTimeFormatter.date(from:  eventDataTable[i].dateTime)!.timeIntervalSince1970, y: 50, width: 20, height: 20))
        }
        
        let eventValueChartDataSet = LineChartDataSet(entries: [eventValueEntry], label: "")
        self.showMarkerView(value: "\(eventValueEntry.y)")
      
        let marker = MarkerView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        marker.chartView = chartView
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let iconImage = UIImage(named: "edit")
        imageView.image = iconImage
        marker.addSubview(imageView)
        chartView.marker = marker
        
        marker.enableMode = .enabled
        
       
        
        
    }
    
    func showMarkerView(value:String) {
        let marker = MarkerView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        marker.chartView = chartView
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: "edit")
        imageView.image = image
        marker.addSubview(imageView)
        chartView.marker = marker
    }
   
    
    // MARK: - randomDataProduce
    
    
    @objc func randonProduce() {
        bloodSugarIndex.append(Int.random(in: 55...400))
        setChartView()
        setImageIcon()
    }
    
    func setImageIcon() {
      
    }
    
    
   
    
    // MARK: - IBAction
    
    @IBAction func clickTimeSegmentControl() {
        switch TimeSegmentControl.selectedSegmentIndex {
        case 0:
            timeWidth = .oneHr
            setChartView()
        case 1:
            timeWidth = .threeHr
            setChartView()
        case 2:
            timeWidth = .sixHr
            setChartView()
        case 3:
            timeWidth = .twelveHr
            setChartView()
        default:
            timeWidth = .twentyFourHr
            setChartView()
        }
    }
    
    @IBAction func clickForwardButton() {
        let time: TimeInterval = Date().timeIntervalSince1970
        chartView.moveViewToX(time)
    }
   
}

// MARK: - Extensions
//extension HistoryViewController: ChartViewDelegate {
//    func mar
//}


// MARK: - Protocol


