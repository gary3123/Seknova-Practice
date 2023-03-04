//
//  ReportFormViewController.swift
//  Seknova-Practice
//
//  Created by Gary on 2023/2/9.
//

import UIKit
import Charts

class ReportFormViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var reportFormSegmentedControl: UISegmentedControl!
    @IBOutlet weak var timeIntervalSegmentedControl: UISegmentedControl!
    @IBOutlet weak var showDateLabel: UILabel!
    @IBOutlet weak var timeIntervalLabel: UILabel!
    @IBOutlet weak var barChartView: BarChartView!

    
    // MARK: - Variables
    enum TimeInterval {
        case sevenDays
        case fourteenDays
        case thirtyDays
    }
    
    var timeInterval: TimeInterval = .sevenDays
    var firstRandomData = [[Double]]()
    var secondRandomData = [[Double]]()
    var thirdRandomData = [[Double]]()
    var fourthRandomData = [[Double]]()
    var fifthRandomData = [[Double]]()
    var firstDataEntry = [ChartDataEntry]()
    var secondDataEntry = [ChartDataEntry]()
    var thirdDataEntry = [ChartDataEntry]()
    var fourthDataEntry = [ChartDataEntry]()
    var fifthDataEntry = [ChartDataEntry]()
    var firstData = ChartDataEntry()
    var secondData = ChartDataEntry()
    var thirdData = ChartDataEntry()
    var fourthData = ChartDataEntry()
    var fifthData = ChartDataEntry()
    var chartData = LineChartData()
    var barChartViewHidden = true
    var upperThenTwoHundredForty = 0
    var oneHundredEightyToTwoHundredForty = 0
    var seventyTooneHundredEighty = 0
    var lessThanseventy = 0
   
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Settings
    
    func setupUI() {
        setupRandomData()
        setupLineChartView()
        setupBarChartView()
    }
    
    func setupRandomData() {
        firstRandomData = [[Double]]()
        secondRandomData = [[Double]]()
        thirdRandomData = [[Double]]()
        fourthRandomData = [[Double]]()
        fifthRandomData = [[Double]]()
        for i in 0 ... 7 {
            firstRandomData.append([Double.random(in: (Double(i) * 3)...( (Double(i) + 1) * 3))
                                    ,Double.random(in: 50 ... 250)])
            secondRandomData.append([Double.random(in: (Double(i) * 3)...( (Double(i) + 1) * 3))
                                     ,Double.random(in: 50 ... 250)])
            thirdRandomData.append([Double.random(in: (Double(i) * 3)...( (Double(i) + 1) * 3))
                                    ,Double.random(in: 50 ... 250)])
            fourthRandomData.append([Double.random(in: (Double(i) * 3)...( (Double(i) + 1) * 3))
                                     ,Double.random(in: 50 ... 250)])
            fifthRandomData.append([Double.random(in: (Double(i) * 3)...( (Double(i) + 1) * 3))
                                    ,Double.random(in: 50 ... 250)])
        }
    }
    
    func setupLineChartView() {
        let xAxisNumberFormatter = ChartXAxisFormatter()
        xAxisNumberFormatter.whichPageToUse = .reportFormLineChartView
        lineChartView.xAxis.valueFormatter = xAxisNumberFormatter
        
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.rightAxis.drawLabelsEnabled = false
        lineChartView.leftAxis.granularity = 50 //最小間隔
        lineChartView.leftAxis.axisMinimum = 0 //最小刻度值
        lineChartView.leftAxis.axisMaximum = 350 //最大刻度值
        lineChartView.leftAxis.labelCount = 7
        lineChartView.drawBordersEnabled = false
        lineChartView.leftAxis.drawAxisLineEnabled = false
        lineChartView.leftAxis.drawBottomYLabelEntryEnabled = false
        lineChartView.rightAxis.drawAxisLineEnabled = false

        lineChartView.legendRenderer.legend?.form = .none
        
        var timeFormatter = DateFormatter()
        timeFormatter.locale = Locale(identifier: "en_US")
        timeFormatter.dateFormat = "ha"
        lineChartView.xAxis.axisMaximum = timeFormatter.date(from: "12AM")!.timeIntervalSince1970 + 3600 * 24
        lineChartView.xAxis.axisMinimum = timeFormatter.date(from: "12AM")!.timeIntervalSince1970
        lineChartView.scaleYEnabled = false
        lineChartView.xAxis.labelCount = 9
        lineChartView.autoScaleMinMaxEnabled = false
        lineChartView.xAxis.forceLabelsEnabled = true
        lineChartView.rightAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.drawGridLinesEnabled = false
    
        timeFormatter.dateFormat = "H"
        for i in 0 ... 7 {
            
            if firstRandomData[i][0] == 0 {
                firstData = ChartDataEntry(x: timeFormatter.date(from: "0")!.timeIntervalSince1970,
                                           y: firstRandomData[i][1])
            } else if secondRandomData[i][0] == 0 {
                firstData = ChartDataEntry(x: timeFormatter.date(from: "0")!.timeIntervalSince1970,
                                           y: secondRandomData[i][1])
            } else if thirdRandomData[i][0] == 0 {
                firstData = ChartDataEntry(x: timeFormatter.date(from: "0")!.timeIntervalSince1970,
                                           y: thirdRandomData[i][1])
            } else if fourthRandomData[i][0] == 0 {
                firstData = ChartDataEntry(x: timeFormatter.date(from: "0")!.timeIntervalSince1970,
                                           y: fourthRandomData[i][1])
            } else if fifthRandomData[i][0] == 0 {
                firstData = ChartDataEntry(x: timeFormatter.date(from: "0")!.timeIntervalSince1970,
                                           y: fifthRandomData[i][1])
            } else if firstRandomData[i][0] == 24{
                firstData = ChartDataEntry(x: timeFormatter.date(from: "0")!.timeIntervalSince1970 + 3600,
                                           y: firstRandomData[i][1])
            } else if secondRandomData[i][0] == 24 {
                firstData = ChartDataEntry(x: timeFormatter.date(from: "23")!.timeIntervalSince1970 + 3600,
                                           y: secondRandomData[i][1])
            } else if thirdRandomData[i][0] == 24 {
                firstData = ChartDataEntry(x: timeFormatter.date(from: "23")!.timeIntervalSince1970 + 3600,
                                           y: thirdRandomData[i][1])
            } else if fourthRandomData[i][0] == 24 {
                firstData = ChartDataEntry(x: timeFormatter.date(from: "23")!.timeIntervalSince1970 + 3600,
                                           y: fourthRandomData[i][1])
            } else if fifthRandomData[i][0] == 24 {
                firstData = ChartDataEntry(x: timeFormatter.date(from: "23")!.timeIntervalSince1970 + 3600,
                                           y: fifthRandomData[i][1])
            } else {
                firstData = ChartDataEntry(x:  timeFormatter.date(from: "\(Int( firstRandomData[i][0] ))")!.timeIntervalSince1970,
                                           y: firstRandomData[i][1])
                secondData = ChartDataEntry(x: timeFormatter.date(from: "\(Int( secondRandomData[i][0] ))")!.timeIntervalSince1970 ,
                                            y: secondRandomData[i][1])
                thirdData = ChartDataEntry(x: timeFormatter.date(from: "\(Int( thirdRandomData[i][0] ))")!.timeIntervalSince1970 ,
                                           y: thirdRandomData[i][1])
                fourthData = ChartDataEntry(x: timeFormatter.date(from: "\(Int( fourthRandomData[i][0] ))")!.timeIntervalSince1970 ,
                                            y: fourthRandomData[i][1])
                fifthData = ChartDataEntry(x: timeFormatter.date(from: "\(Int( fifthRandomData[i][0] ))")!.timeIntervalSince1970 ,
                                           y: fifthRandomData[i][1])
            }
            
            firstDataEntry.append(firstData)
            secondDataEntry.append(secondData)
            thirdDataEntry.append(thirdData)
            fourthDataEntry.append(fourthData)
            fifthDataEntry.append(fifthData)
        }
        let firstDataSet = LineChartDataSet(entries: firstDataEntry, label: "")
        let secondDataSet = LineChartDataSet(entries: secondDataEntry, label: "")
        let thirdDataSet = LineChartDataSet(entries: thirdDataEntry, label: "")
        let fourthDataSet = LineChartDataSet(entries: fourthDataEntry, label: "")
        let fifthDataSet = LineChartDataSet(entries: fifthDataEntry, label: "")
        firstDataSet.mode = .horizontalBezier
        firstDataSet.drawCirclesEnabled = false
        firstDataSet.drawValuesEnabled = false
        firstDataSet.fillColor = .tintColor
        firstDataSet.drawFilledEnabled = true
        firstDataSet.fillAlpha = 0.5
        firstDataSet.colors = [.clear]
        firstDataSet.highlightEnabled = false
        
        secondDataSet.mode = .horizontalBezier
        secondDataSet.drawCirclesEnabled = false
        secondDataSet.drawValuesEnabled = false
        secondDataSet.fillColor = .tintColor
        secondDataSet.drawFilledEnabled = true
        secondDataSet.fillAlpha = 0.5
        secondDataSet.colors = [.clear]
        secondDataSet.highlightEnabled = false
        
        thirdDataSet.mode = .horizontalBezier
        thirdDataSet.drawCirclesEnabled = false
        thirdDataSet.drawValuesEnabled = false
        thirdDataSet.colors = [.black]
        thirdDataSet.lineWidth = 3
        thirdDataSet.highlightEnabled = false
        
        fourthDataSet.mode = .horizontalBezier
        fourthDataSet.drawCirclesEnabled = false
        fourthDataSet.drawValuesEnabled = false
        fourthDataSet.fillColor = .tintColor
        fourthDataSet.drawFilledEnabled = true
        fourthDataSet.fillAlpha = 0.5
        fourthDataSet.colors = [.clear]
        fourthDataSet.highlightEnabled = false
        
        fifthDataSet.mode = .horizontalBezier
        fifthDataSet.drawCirclesEnabled = false
        fifthDataSet.drawValuesEnabled = false
        fifthDataSet.fillColor = .tintColor
        fifthDataSet.drawFilledEnabled = true
        fifthDataSet.fillAlpha = 0.5
        fifthDataSet.colors = [.clear]
        fifthDataSet.highlightEnabled = false
        
        chartData = LineChartData(dataSets: [firstDataSet, secondDataSet, thirdDataSet, fourthDataSet, fifthDataSet])
        lineChartView.data = chartData
    }
    
    func setupBarChartView() {
        let xAxisNumberFormatter = ChartXAxisFormatter()
        xAxisNumberFormatter.whichPageToUse = .reportFormBarChartView
        barChartView.xAxis.valueFormatter = xAxisNumberFormatter
        barChartView.xAxis.labelFont = UIFont.systemFont(ofSize: 17)
        
        countBarChartViewData(data: firstRandomData)
        countBarChartViewData(data: secondRandomData)
        countBarChartViewData(data: thirdRandomData)
        countBarChartViewData(data: fourthRandomData)
        countBarChartViewData(data: fifthRandomData)
        barChartView.legendRenderer.legend?.form = .none
        barChartView.scaleXEnabled = false
        barChartView.scaleYEnabled = false
        barChartView.autoScaleMinMaxEnabled = false
        barChartView.xAxis.granularity = 1
        barChartView.xAxis.axisMaximum = 5
        barChartView.xAxis.axisMinimum = 0
        barChartView.xAxis.labelCount = 6
        
        
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.drawAxisLineEnabled = false
        barChartView.xAxis.labelPosition = .bottom
        barChartView.leftAxis.drawLabelsEnabled = false
        barChartView.leftAxis.drawGridLinesEnabled = false
        barChartView.leftAxis.drawAxisLineEnabled = false
        barChartView.rightAxis.drawLabelsEnabled = false
        barChartView.rightAxis.drawAxisLineEnabled = false
        barChartView.rightAxis.drawGridLinesEnabled = false
        barChartView.rightAxis.drawAxisLineEnabled = false

        barChartView.drawBordersEnabled = false
        

        let formatter = NumberFormatter()
        formatter.positivePrefix = "%"
        var dataEntries = [BarChartDataEntry]()
        for i in 0 ... 5 {
            switch i {
            case 0:
                let entry = BarChartDataEntry(x: Double(i), y: 0)
                dataEntries.append(entry)
            case 1:
                let entry = BarChartDataEntry(x: Double(i), y: (Double(upperThenTwoHundredForty) / 40) * 100 )
                dataEntries.append(entry)
            case 2:
                let entry = BarChartDataEntry(x: Double(i), y: (Double(oneHundredEightyToTwoHundredForty) / 40) * 100)
                dataEntries.append(entry)
            case 3:
                let entry = BarChartDataEntry(x: Double(i), y: (Double(seventyTooneHundredEighty) / 40) * 100)
                dataEntries.append(entry)
            case 4:
                let entry = BarChartDataEntry(x: Double(i), y: (Double(lessThanseventy) / 40) * 100)
                dataEntries.append(entry)
            default:
                let entry = BarChartDataEntry(x: Double(i), y: 0)
                dataEntries.append(entry)
            }
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "")
        chartDataSet.valueFormatter = DefaultValueFormatter(formatter: formatter)
        chartDataSet.colors = [.clear,
                               .upperThanTwoHundredFourty!,
                               .oneHundredEightyToTwoHundredForty!,
                               .seventyTooneHundredEighty!,
                               .lessThanseventy!,
                               .clear]
        chartDataSet.highlightEnabled = false
        chartDataSet.valueFont = UIFont.systemFont(ofSize: 15)
        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.barWidth = 0.7
        
        
        barChartView.data = chartData
        
        
    }
    
    func countBarChartViewData(data: [[Double]]) {
        for i in 0 ... 7 {
            switch data[i][1] {
            case 181 ... 240:
                oneHundredEightyToTwoHundredForty += 1
            case 70 ... 180:
                seventyTooneHundredEighty += 1
            case 0 ... 70:
                lessThanseventy += 1
            default:
                upperThenTwoHundredForty += 1
            }
        }
    }
    
    
    // MARK: - IBAction
    @IBAction func clickTimeIntervalSegmentedControl() {
//        let emptyEntry = [ChartDataEntry]()
//        let emptyDataSet = LineChartDataSet(entries: emptyEntry, label: "")
//        chartData = LineChartData(dataSets: [emptyDataSet])
        setupRandomData()
        setupLineChartView()
        setupBarChartView()
    }
    
    @IBAction func clickReportFormSegmentedControl() {
        if reportFormSegmentedControl.selectedSegmentIndex == 0 {
            barChartViewHidden = true
        } else {
            barChartViewHidden = false
        }
        
        if barChartViewHidden == true {
            barChartView.isHidden = true
            lineChartView.isHidden = false
        } else {
            barChartView.isHidden = false
            lineChartView.isHidden = true
        }
    }
    
   
    
}

// MARK: - Extension



// MARK: - Protocol
