//
//  CurrencyDetailViewController.swift
//  CurrencyApp
//
//  Created by badal on 01/12/22.
//

import UIKit
import RxSwift
import RxCocoa

enum InformationType {
    case historicalData
    case otherCurrencyData
}
var historicalDataChart = [HistoricalDataModel]()

class CurrencyDetailViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currencySegment: UISegmentedControl!
    @IBOutlet weak var viewChart: UIView!

    public var currencyData = PublishSubject<[CurrencyModel]>()
    var historicalData = PublishSubject<[HistoricalDataModel]>()
    
    public var informationType: InformationType = .historicalData
    
    var fromCurrencyValue: String = StringConstants.emptyString
    var fromCurrencyCode: String = StringConstants.emptyString
    var toCurrencyCode: String = StringConstants.emptyString
    var toCurrencyValue: String = StringConstants.emptyString
    
    let disposeBag = DisposeBag()
    var currencyDetailViewModel = CurrencyDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historicalDataChart.removeAll()
        switch informationType {
        case .historicalData:
            tableView.register(UINib(nibName: CellConstants.historicalDataCell, bundle: nil), forCellReuseIdentifier: String(describing: HistoricalDataTableViewCell.self))
            
            historicalData.bind(to: tableView.rx.items(cellIdentifier: CellConstants.historicalDataCell, cellType: HistoricalDataTableViewCell.self)) {  (row,track,cell) in
                historicalDataChart.append(track)
                cell.dateLabel.text = "Date :- " + track.dateString
                cell.valueLabel.text = track.toCurrencySymobl + " :- " + track.toCurrencyValue
                cell.usdLabel.text = "USD :- " + (track.dollarSymbol ?? "")
                cell.gbpLabel.text = "GBP :- " + (track.britishPoundSymbol ?? "")
                cell.euroLabel.text = "EURO :- " + (track.euroSymbol ?? "")
                cell.egpLabel.text = "EGP :- " + (track.egyptPoundSymbol ?? "")
                cell.cadLabel.text = "CAD :- " + (track.canadianDollarSymbol ?? "")
                cell.inrLabel.text = "INR :- " + (track.indianRupeeSymbol ?? "")
                cell.ausLabel.text = "AUD :- " + (track.australianDollarSymbol ?? "")
                cell.jpyLabel.text = "JPY :- " + (track.japaneseYenSymbol ?? "")
                cell.cnyLabel.text = "CNY :- " + (track.chineseSymbol ?? "")
                cell.qarLabel.text = "QAR :- " + (track.qatarRiyalSymbol ?? "")

            }.disposed(by: disposeBag)
            
        case .otherCurrencyData:
            tableView.register(UINib(nibName: CellConstants.otherCurrencyDataCell, bundle: nil), forCellReuseIdentifier: String(describing: OtherCurrencyDataTableViewCell.self))
            
            currencyData.bind(to: tableView.rx.items(cellIdentifier: CellConstants.otherCurrencyDataCell, cellType: OtherCurrencyDataTableViewCell.self)) {  (row,track,cell) in
                //cell.cellModel = track
                }.disposed(by: disposeBag)
        }
        setupBindings()
        currencyDetailViewModel.getConvertedCurrency(fromSymbol: fromCurrencyCode, toSymbol: currencyDetailViewModel.getPopularCurrencySymbols(), valueToConvert: fromCurrencyValue)
        currencyDetailViewModel.getHistoricalCurrencyData(fromSymbol: fromCurrencyCode, toSymbol: toCurrencyCode, valueToConvert: fromCurrencyValue, convertedLatestValue: toCurrencyValue)
        
        
    }
    
    private func setupBindings() {

        currencyDetailViewModel
            .currencyModel
            .observe(on: MainScheduler.instance)
            .bind(to: currencyData)
            .disposed(by: disposeBag)
        
        currencyDetailViewModel
            .historicalDataModel
            .observe(on: MainScheduler.instance)
            .bind(to: historicalData)
            .disposed(by: disposeBag)
        
        currencyDetailViewModel.error.observe(on: MainScheduler.instance)
            .subscribe(onNext: { [ weak self ]error in
                guard let self = self else { return }
                self.parseNetworkError(error: error)
                
            }).disposed(by: disposeBag)
       
    }
    @IBAction func segmentClicked(_ sender: Any) {
        
        if self.currencySegment.selectedSegmentIndex == 0{
            self.tableView.isHidden = false
            self.viewChart.isHidden = true
        }else{
            self.tableView.isHidden = true
            self.viewChart.isHidden = false
            NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil)
        }
    }
    
}
