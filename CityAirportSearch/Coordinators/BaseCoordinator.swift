//
//  BaseCoordinator.swift
//  CityAirportSearch
//
//  Created by Shreya on 06/07/20.
//  Copyright © 2020 Shreya Pallan. All rights reserved.
//

import Foundation


class BaseCoordinator : Coordinator {
    var childCoordinators: [Coordinator] = []
    
    func start() {
        fatalError("Children should implement 'start'.")
    }
    
    
}
