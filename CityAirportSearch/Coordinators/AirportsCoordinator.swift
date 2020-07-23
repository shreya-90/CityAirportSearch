//
//  AirportsCoordinator.swift
//  CityAirportSearch
//
//  Created by Shreya on 18/07/20.
//  Copyright © 2020 Shreya Pallan. All rights reserved.
//

import Foundation
import UIKit

class AirportsCoordinator : BaseCoordinator {
    
    private var navigationController : UINavigationController!
    private let models : Set<AirportModel>
    
    init(models : Set<AirportModel>,
         navigationController : UINavigationController) {
        self.navigationController = navigationController
        self.models = models
        
    }
    
    override func start() {
        let view = AirportDetailsViewController.instantiate()
        let locationService = LocationService.shared
        //View Model ASSOCIATION // Need to understand
        view.viewModelBuilder = { [models,locationService] in
            let title = models.first?.city ?? ""
            return AirportsViewModel(input: $0, dependancies: (
                title:title,
                models: models,
                currentLocation:locationService.currentLocation)
            )
        }
        self.navigationController.pushViewController(view, animated:true)
    }
}
