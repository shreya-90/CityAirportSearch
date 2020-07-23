//
//  AirportCellViewModel.swift
//  CityAirportSearch
//
//  Created by Shreya on 19/07/20.
//  Copyright © 2020 Shreya Pallan. All rights reserved.
//

import Foundation
import CoreLocation




protocol AirportCellViewPresentable {
    var name : String { get}
    var code : String  { get }
    var address : String { get }
    var distance : Double? { get }
    var formattedDistance : String { get }
    var runwayLength  : String { get }
    var location : (lat : String, lon : String) { get }
    
    
}

struct AirportCellViewModel : AirportCellViewPresentable {
    var name: String
    var code: String
    var address: String
    var distance: Double?
    var formattedDistance: String {

        let formatted = ((distance ?? 0) * 1.6/1000).rounded(.up)  // miles to km
        return "\(formatted) Km"
    }
    
    var runwayLength: String
    var location: (lat: String, lon: String)
    
    
}


extension AirportCellViewModel {
    
    init(usingModel model : AirportModel,currentLocation:(lat: Double, lon: Double)){
        self.name = model.name
        self.code = model.code
        self.address = "\(model.country ?? "") \(model.country)"
        self.runwayLength = "\(model.runwayLength ?? "NA")"
        self.location = (lat : model.lat, lon : model.lon)
        
        ///FIX ME - Distance Calculation from current location to airport
        self.distance = AirportCellViewModel.getDistance(model: model,currentLocation: currentLocation)
    }
}


private extension AirportCellViewModel {
    
    
    static func getDistance(model: AirportModel,
                            currentLocation: (lat: Double, lon: Double)) -> Double? {
         guard let lat = Double(model.lat), let lon = Double(model.lon) else { return nil }
         let currentLocation = CLLocation(latitude: currentLocation.lat,
                                                 longitude: currentLocation.lon)
         let airportLocation = CLLocation(latitude: lat, longitude: lon)
         return currentLocation.distance(from: airportLocation)
    }
    
}
