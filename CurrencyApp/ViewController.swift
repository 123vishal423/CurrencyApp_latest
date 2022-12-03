//
//  ViewController.swift
//  CurrencyApp
//
//  Created by badal on 01/12/22.
//

import UIKit
import AAInfographics
class ViewController: UIViewController {

    
    var aaChartView:AAChartView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)

        let chartViewWidth  = self.view.frame.size.width
        let chartViewHeight = 400.0
        aaChartView = AAChartView()
        aaChartView?.frame = CGRect(x: 0,
                                    y: 60,
                                    width: chartViewWidth,
                                    height: chartViewHeight)
        // set the content height of aachartView
        // aaChartView?.contentHeight = self.view.frame.size.height
        self.view.addSubview(aaChartView!)
        

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

    }

    @objc func methodOfReceivedNotification(notification: Notification) {
        _ = historicalDataChart.map{$0.toCurrencyValue}
        let tovalue = historicalDataChart.map{$0.toCurrencySymobl}.first

        let aaChartModel = AAChartModel()
            .chartType(.area)//Can be any of the chart types listed under `AAChartType`.
            .animationType(.bounce)
            .title(tovalue ?? "")//The chart title
            .subtitle("")//The chart subtitle
            .dataLabelsEnabled(false) //Enable or disable the data labels. Defaults to false
            .tooltipValueSuffix("USD")//the value suffix of the chart tooltip
            .categories(historicalDataChart.map{$0.dateString})
            .colorsTheme(["#fe117c","#ffc069","#06caf4","#7dffc0"])
            .series([
                AASeriesElement()
                    .name(tovalue ?? "")
                    .data(historicalDataChart.map{Double($0.toCurrencyValue) ?? 0.0})
                    ])
        aaChartView?.aa_drawChartWithChartModel(aaChartModel)
    }

}

