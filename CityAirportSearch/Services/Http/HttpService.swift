//
//  HttpService.swift
//  CityAirportSearch
//
//  Created by Shreya on 07/07/20.
//  Copyright © 2020 Shreya Pallan. All rights reserved.
//

import Foundation
import Alamofire

protocol HttpService {
    var sessionManager : Session { get set }
    func request(_ urlRequest : URLRequestConvertible) -> DataRequest
}
