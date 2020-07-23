//
//  AirportAPI.swift
//  CityAirportSearch
//
//  Created by Shreya on 07/07/20.
//  Copyright © 2020 Shreya Pallan. All rights reserved.
//

import Foundation

import RxSwift
protocol AirportAPI {
  //  func fetchAirports(completion : @escaping AirportResonse) //Non Rx way
    func fetchAirports() -> Single<AirportsResponse>   //Rx way
}
