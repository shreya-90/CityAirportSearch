//
//  AirportHttpRouter.swift
//  CityAirportSearch
//
//  Created by Shreya on 07/07/20.
//  Copyright © 2020 Shreya Pallan. All rights reserved.
//

import Foundation
import Alamofire

enum AirportHttpRouter  {
    case getAirports
}



extension AirportHttpRouter : HttpRouter {

    var baseUrlString: String {
        return "https://gist.githubusercontent.com/tdreyno/4278655/raw/7b0762c09b519f40397e4c3e100b097d861f5588"
    }
    
    var path: String {
        switch self {
        case .getAirports:
            return "airports.json"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAirports:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
           switch (self) {
           case .getAirports:
               return nil
           }
    }
       
    var parameters: Parameters? {
           return nil
    }
    
    func body() throws -> Data? {
        switch self {
        case .getAirports:
            return nil
        }
    }
}
