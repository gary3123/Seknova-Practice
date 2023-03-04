//
//  ChartXAxisFormatter.swift
//  Seknova-Practice
//
//  Created by Gary on 2022/12/22.
//

import Foundation
import Charts

class ChartXAxisFormatter: NSObject {
    var whichPageToUse: WhichPageToUse = .instanceBloodSugar
    
    enum WhichPageToUse {
        case instanceBloodSugar
        case reportFormLineChartView
        case history
        case reportFormBarChartView
    }
    
    fileprivate var dateFormatter: DateFormatter?
    fileprivate var referenceTimeInterval: TimeInterval?
    
    convenience init(referenceTimeInterval: TimeInterval, dateFormatter: DateFormatter) {
        self.init()
        self.referenceTimeInterval = referenceTimeInterval
        self.dateFormatter = dateFormatter
    }
}

extension ChartXAxisFormatter: AxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        let dateFormatterPrint = DateFormatter()
        if whichPageToUse == .instanceBloodSugar {
            dateFormatterPrint.dateFormat = "HH:mm"
            let date = Date(timeIntervalSince1970: value)
            return dateFormatterPrint.string(from: date)
        } else if whichPageToUse == .history {
            dateFormatterPrint.dateFormat = "MM/dd HH:mm"
            let date = Date(timeIntervalSince1970: value)
            return dateFormatterPrint.string(from: date)
        } else if whichPageToUse == .reportFormLineChartView{
            dateFormatterPrint.amSymbol = "am"
            dateFormatterPrint.pmSymbol = "pm"
            dateFormatterPrint.dateFormat = "ha"
            let date = Date(timeIntervalSince1970: value)
            return dateFormatterPrint.string(from: date)
        } else {
            let barChartViewXaixs = ["",">240","180-240","70-180","<70",""]
            return barChartViewXaixs[Int(value)]
        }
    }
    
}
