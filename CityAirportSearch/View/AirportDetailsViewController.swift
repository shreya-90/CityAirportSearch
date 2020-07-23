//
//  AirportDetailsViewController.swift
//  CityAirportSearch
//
//  Created by Shreya on 17/07/20.
//  Copyright © 2020 Shreya Pallan. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class AirportDetailsViewController: UIViewController , Storyboardable { 

    
    @IBOutlet weak var tableView: UITableView!
    
    
    private var viewModel : AirportsViewPresentable!
    var viewModelBuilder : AirportsViewPresentable.ViewModelBuilder!
    
    
    private var bag = DisposeBag()
    
    private static let CellId = "AirportCellId"
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<AirportItemsSection>(configureCell: {(_, tableview, indexPath,item ) in
        let airportCell = tableview.dequeueReusableCell(withIdentifier: AirportDetailsViewController.CellId, for: indexPath) as! AirportCell
        airportCell.configure(usingViewModel: item )
        return airportCell
    })
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.viewModel = viewModelBuilder(())   // View Model Creation
        self.setupUI()
        self.setupBinding()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}

private extension AirportDetailsViewController {
    
    func setupUI() -> Void {
        tableView.register(UINib(nibName: "AirportCell", bundle: nil), forCellReuseIdentifier: AirportDetailsViewController.CellId)
    }
    
    func setupBinding() {
        
        //bind viewmodel with tableview
        self.viewModel.output.airports
            .drive(self.tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
        
        self.viewModel.output
            .title.drive(self.rx.title)   // title is bound
            .disposed(by: bag)
    }
}
