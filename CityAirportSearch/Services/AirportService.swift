//
//  AirportService.swift
//  CityAirportSearch
//
//  Created by Shreya on 07/07/20.
//  Copyright © 2020 Shreya Pallan. All rights reserved.
//

import RxSwift
import Alamofire

class AirportService {
    
    private lazy var httpService = AirportHttpService()
    static let shared : AirportService = AirportService()
}


extension AirportService : AirportAPI {
    
    func fetchAirports() -> Single<AirportsResponse> {
        
        return Single.create { [httpService] (single) -> Disposable in
            
            do {
                try AirportHttpRouter.getAirports
                    .request(usingHttpService: self.httpService)
                    .responseJSON { (result) in
                        
                        do {
                            let airports = try AirportService.parseAirports(result: result)
                            single(.success(airports))
                        } catch
                        {
                            print("Airports fetch failed with error: \(error)")
                            single(.error(error))
                        }
                       
                }
            } catch {
                single(.error(CustomError.error(message: "Airport fetch failed")))
            }
           
            return Disposables.create()
        }
    }
}


extension AirportService {
    
    static func parseAirports(result : AFDataResponse<Any> ) throws -> AirportsResponse {
        
        guard
            let data = result.data,
            let airportsResponse = try? JSONDecoder().decode(AirportsResponse.self, from : data)
            else {
                throw CustomError.error(message: "Invalid Airports JSON")
            }
        return airportsResponse
    }
}
