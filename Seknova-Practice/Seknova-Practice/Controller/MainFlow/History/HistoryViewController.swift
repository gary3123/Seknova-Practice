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
    @IBOutlet weak var timeSegmentControl: UISegmentedControl!
    @IBOutlet weak var eventValueDetailView: UIView!
    @IBOutlet weak var eventValueLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var remarkLabel: UILabel!
    
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
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadHistoryChartView),
                                               name: .reloadHistoryChartViewData,
                                               object: nil)
        setupUI()
        
    }
    
    
    // MARK: - UI Settings
    func setupUI() {
        setChartView()
        setupEventValueDetailView()
    }
    
    func setChartView() {
        chartView.delegate = self
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
            let entry = ChartDataEntry(x: Date().timeIntervalSince1970,
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
       
        
        
        //設定 EventImage
        var imageChartDataEntryArray = [ChartDataEntry]()
        for i in 0 ..< eventDataTable.count {
            let imageChartDataEntry = ChartDataEntry(x: dateTimeFormatter.date(from: eventDataTable[i].dateTime)!.timeIntervalSince1970,
                                            y: 30)
            imageChartDataEntry.data = i
            switch eventDataTable[i].eventId {
            case 2:
                switch eventDataTable[i].eventValue {
                case 0:
                    let image = resizeImage(image: UIImage(named: "breakfast")!, targetSize: CGSizeMake(50, 50))
                    imageChartDataEntry.icon = image
                    imageChartDataEntryArray.append(imageChartDataEntry)
                case 1:
                    let image = resizeImage(image: UIImage(named: "lunch")!, targetSize: CGSizeMake(50, 50))
                    imageChartDataEntry.icon = image
                    imageChartDataEntryArray.append(imageChartDataEntry)
                case 2:
                    let image = resizeImage(image: UIImage(named: "dinner")!, targetSize: CGSizeMake(50, 50))
                    imageChartDataEntry.icon = image
                    imageChartDataEntryArray.append(imageChartDataEntry)
                case 3:
                    let image = resizeImage(image: UIImage(named: "snacks")!, targetSize: CGSizeMake(50, 50))
                    imageChartDataEntry.icon = image
                    imageChartDataEntryArray.append(imageChartDataEntry)
                default:
                    let image = resizeImage(image: UIImage(named: "drinks")!, targetSize: CGSizeMake(50, 50))
                    imageChartDataEntry.icon = image
                    imageChartDataEntryArray.append(imageChartDataEntry)
                }
            case 3:
                switch eventDataTable[i].eventValue {
                case 0:
                    let image = resizeImage(image: UIImage(named: "high_motion")!, targetSize: CGSizeMake(50, 50))
                    imageChartDataEntry.icon = image
                    imageChartDataEntryArray.append(imageChartDataEntry)
                case 1:
                    let image = resizeImage(image: UIImage(named: "mid_motion")!, targetSize: CGSizeMake(50, 50))
                    imageChartDataEntry.icon = image
                    imageChartDataEntryArray.append(imageChartDataEntry)
                default:
                    let image = resizeImage(image: UIImage(named: "low_motion")!, targetSize: CGSizeMake(50, 50))
                    imageChartDataEntry.icon = image
                    imageChartDataEntryArray.append(imageChartDataEntry)
                }
            case 4:
                switch eventDataTable[i].eventValue {
                case 0:
                    let image = resizeImage(image: UIImage(named: "sleep")!, targetSize: CGSizeMake(50, 50))
                    imageChartDataEntry.icon = image
                    imageChartDataEntryArray.append(imageChartDataEntry)
                case 1:
                    let image = resizeImage(image: UIImage(named: "sleepy")!, targetSize: CGSizeMake(50, 50))
                    imageChartDataEntry.icon = image
                    imageChartDataEntryArray.append(imageChartDataEntry)
                case 2:
                    let image = resizeImage(image: UIImage(named: "nap")!, targetSize: CGSizeMake(50, 50))
                    imageChartDataEntry.icon = image
                    imageChartDataEntryArray.append(imageChartDataEntry)
                default:
                    let image = resizeImage(image: UIImage(named: "relax")!, targetSize: CGSizeMake(50, 50))
                    imageChartDataEntry.icon = image
                    imageChartDataEntryArray.append(imageChartDataEntry)
                }
            case 5:
                switch eventDataTable[i].eventValue {
                case 0:
                    let image = resizeImage(image: UIImage(named: "insulin")!, targetSize: CGSizeMake(50, 50))
                    imageChartDataEntry.icon = image
                    imageChartDataEntryArray.append(imageChartDataEntry)
                case 1:
                    let image = resizeImage(image: UIImage(named: "insulin")!, targetSize: CGSizeMake(50, 50))
                    imageChartDataEntry.icon = image
                    imageChartDataEntryArray.append(imageChartDataEntry)
                default:
                    let image = resizeImage(image: UIImage(named: "insulin")!, targetSize: CGSizeMake(50, 50))
                    imageChartDataEntry.icon = image
                    imageChartDataEntryArray.append(imageChartDataEntry)
                }
            default:
                break
            }
            
            
        }
        let imageChartDataSet = LineChartDataSet(entries: imageChartDataEntryArray, label: "")
        imageChartDataSet.colors = [.clear]
        imageChartDataSet.drawCirclesEnabled = false
        imageChartDataSet.mode = .horizontalBezier
        imageChartDataSet.drawValuesEnabled = false
        imageChartDataSet.highlightColor = .clear
        let chartData = LineChartData(dataSets: [instanceBloodChartDataSet, imageChartDataSet])
        chartView.data = chartData
        
    }
    
    func setupEventValueDetailView() {
        eventValueDetailView.layer.borderColor = UIColor.navigationBar?.cgColor
        eventValueDetailView.layer.borderWidth = 5
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
   
    
    // MARK: - randomDataProduce
    
    
    @objc func randonProduce() {
        bloodSugarIndex.append(Int.random(in: 150...250))
        setChartView()
    }
    
    
   
    
    // MARK: - IBAction
    
    @IBAction func clickTimeSegmentControl() {
        switch timeSegmentControl.selectedSegmentIndex {
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
    
    @IBAction func clickEnlargeButton() {
        let nextVC = EnlargeHistoryViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func reloadHistoryChartView() {
        setChartView()
    }
     
}

// MARK: - Extensions
extension HistoryViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        let eventDataTable = realm.objects(EventData.self)
        eventValueDetailView.isHidden = false
        let dataIndex = Int("\(entry.data!)")
        
        switch eventDataTable[dataIndex!].eventId {
        case 2:
            switch eventDataTable[dataIndex!].eventValue {
            case 0:
                eventValueLabel.text = "早餐"
            case 1:
                eventValueLabel.text = "午餐"
            case 2:
                eventValueLabel.text = "晚餐"
            case 3:
                eventValueLabel.text = "點心"
            default:
                eventValueLabel.text = "飲料"
            }
        case 3:
            switch eventDataTable[dataIndex!].eventValue {
            case 0:
                eventValueLabel.text = "高強度"
            case 1:
                eventValueLabel.text = "中強度"
            default:
                eventValueLabel.text = "低強度"
            }
        case 4:
            switch eventDataTable[dataIndex!].eventValue {
            case 0:
                eventValueLabel.text = "就寢"
            case 1:
                eventValueLabel.text = "午睡"
            case 2:
                eventValueLabel.text = "小憩"
            default:
                eventValueLabel.text = "放鬆時刻"
            }
        case 5:
            switch eventDataTable[dataIndex!].eventValue {
            case 0:
                eventValueLabel.text = "速效型"
            case 1:
                eventValueLabel.text = "長效型"
            default:
                eventValueLabel.text = "未指定"
            }
        default:
            break
        }
        let realmDateTimeFormatter = DateFormatter()
        realmDateTimeFormatter.locale = Locale(identifier: "zh_TW")
        realmDateTimeFormatter.dateFormat = "yyyy/MM/dd EEEE a hh:mm"
        let showDateTimeFormatter = DateFormatter()
        showDateTimeFormatter.locale = Locale(identifier: "zh_TW")
        showDateTimeFormatter.dateFormat = "MM/dd hh:mm"
        dateTimeLabel.text = showDateTimeFormatter.string(from: realmDateTimeFormatter.date(from: eventDataTable[dataIndex!].dateTime)!)
        remarkLabel.text = eventDataTable[dataIndex!].note
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        eventValueDetailView.isHidden = true
    }
}
// MARK: - Protocol


