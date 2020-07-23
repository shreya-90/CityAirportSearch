//
//  Coordinator.swift
//  CityAirportSearch
//
//  Created by Shreya on 06/07/20.
//  Copyright © 2020 Shreya Pallan. All rights reserved.
//

import Foundation

protocol Coordinator : class {
    
    var childCoordinators : [Coordinator] {get set}
    
    func start()
}

extension Coordinator {
    

    func add(coordinator : Coordinator) -> Void {
        childCoordinators.append(coordinator)
    }
    
    func remove(coordinator : Coordinator) -> Void {
       childCoordinators = childCoordinators.filter({ $0 !== coordinator })
    }
}
