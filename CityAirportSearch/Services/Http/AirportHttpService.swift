//
//  AirportHttpService.swift
//  CityAirportSearch
//
//  Created by Shreya on 07/07/20.
//  Copyright © 2020 Shreya Pallan. All rights reserved.
//

import Foundation
import Alamofire

class AirportHttpService : HttpService {
    var sessionManager: Session =  Session.default
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest {
        return sessionManager.request(urlRequest).validate(statusCode: 200..<400)
    }
    
}
