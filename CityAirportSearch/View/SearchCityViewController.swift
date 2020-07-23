//
//  ViewController.swift
//  CityAirportSearch
//
//  Created by Shreya on 03/07/20.
//  Copyright © 2020 Shreya Pallan. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class  SearchCityViewController: UIViewController,Storyboardable {

    
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    private static let CellId = "CityCellId"
    
    private let bag = DisposeBag()
    
    private lazy var datasource = RxTableViewSectionedReloadDataSource<CityItemsSection>(configureCell: {_,tableView,indexPath, item in
        
        let cityCell = tableView.dequeueReusableCell(withIdentifier: SearchCityViewController.CellId, for: indexPath) as! CityCellTableViewCell
        cityCell.configure(usingViewModel: item)
        return cityCell
    })
    
    private var viewModel : SearchCityViewPresentable!
    var viewModelBuilder : SearchCityViewPresentable.ViewModelBuilder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.viewModel = viewModelBuilder((
            searchText : searchTextField.rx.text.orEmpty.asDriver(),
            citySelect : tableView.rx.modelSelected(CityViewModel.self).asDriver()
        ))
        
        setupUI()
        setUpBinding()
    }


}

private extension SearchCityViewController {
    
    func setupUI() -> Void {
        tableView.register(UINib(nibName: "CityCellTableViewCell", bundle: nil), forCellReuseIdentifier: SearchCityViewController.CellId)
        self.title = "Airports"
    }
    
    func setUpBinding() -> Void {
        self.viewModel.output.cities.drive(tableView.rx.items(dataSource: self.datasource))
        .disposed(by: bag)
    }
}


