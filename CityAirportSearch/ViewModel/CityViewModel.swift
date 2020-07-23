//
//  CityViewModel.swift
//  CityAirportSearch
//
//  Created by Shreya on 16/07/20.
//  Copyright © 2020 Shreya Pallan. All rights reserved.
//

import Foundation
import RxDataSources

typealias CityItemsSection = SectionModel<Int,CityViewModelPresentable>

protocol CityViewModelPresentable {
    var city : String { get }
    var location : String { get }
}

struct CityViewModel : CityViewModelPresentable {
    var city: String
    var location: String

}

extension CityViewModel {
    
    init(model:AirportModel) {
        self.city = model.city
        self.location = "\(model.state ?? ""),\(model.country)"
    }
}

extension CityViewModel: Equatable {
    
    static func == (lhs: CityViewModel, rhs: CityViewModel) -> Bool {
        return lhs.city == rhs.city
    }
}

extension CityViewModel: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(city)
    }
}
