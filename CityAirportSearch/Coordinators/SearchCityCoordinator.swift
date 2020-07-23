//
//  SearchCityCoordinator.swift
//  CityAirportSearch
//
//  Created by Shreya on 06/07/20.
//  Copyright © 2020 Shreya Pallan. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class SearchCityCoordinator : BaseCoordinator{
    private var navigationController : UINavigationController!
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    let disposeBag = DisposeBag()
    
    override func start() {
        
        let view = SearchCityViewController.instantiate()  // 1
        
        let service = AirportService.shared
      
        // dont want to expose view model so we created a viewmodelbuilder
        view.viewModelBuilder = { [disposeBag] in
            let viewModel = SearchCityViewModel(input: $0, airportService: service)   // accepting the driver passed here in the closure. As driver passed from VC gets accepted here, the view model is created in the VC. This is the place where passing the closure to create the view model  //2
            viewModel.router.citySelected
                .map ({ [weak self] (models) in
                    //print("Models received  - \(models)")
                    guard let `self` = self else  { return }
                    self.showAirports(usingModel: models)
                })
            .drive()
            .disposed(by: disposeBag)
            
            return viewModel
        }
        
        navigationController.pushViewController(view, animated: true) //3
    }
}


extension SearchCityCoordinator {
    
    func showAirports(usingModel models : Set<AirportModel>) -> Void {
        
        let airportCoordinator = AirportsCoordinator(models: models, navigationController: self.navigationController)
        self.add(coordinator: airportCoordinator)
        airportCoordinator.start()
   
    }
}
