//
//  AirportsViewModel.swift
//  CityAirportSearch
//
//  Created by Shreya on 17/07/20.
//  Copyright © 2020 Shreya Pallan. All rights reserved.
//

import Foundation
import RxDataSources
import RxCocoa
import CoreLocation
import RxSwift

typealias AirportItemsSection = SectionModel<Int,AirportCellViewPresentable>
protocol AirportsViewPresentable {
    
    typealias Output = (
        title : Driver<String>,
        airports : Driver<[AirportItemsSection]>
       
        
    )
    typealias Input = ()
    
    typealias Dependancies = (
        title : String,
        models : Set<AirportModel>,
        currentLocation : Observable<(lat:Double,lon:Double)?>
    )
    
    typealias ViewModelBuilder = (AirportsViewPresentable.Input) -> AirportsViewPresentable
    
    var output : AirportsViewPresentable.Output { get }
    var input : AirportsViewPresentable.Input { get }
}

struct AirportsViewModel: AirportsViewPresentable {
    
    
    var input: AirportsViewPresentable.Input
    var output: AirportsViewPresentable.Output
    
    init(input : AirportsViewPresentable.Input, dependancies : AirportsViewPresentable.Dependancies){
        self.input = input
        self.output = AirportsViewModel.output(dependancies: dependancies)
        
    }
    
    
}

private extension AirportsViewModel {
    
    static func output(dependancies : AirportsViewPresentable.Dependancies) -> AirportsViewPresentable.Output {
        
        let sections = Observable.just(dependancies.models)
            .withLatestFrom(dependancies.currentLocation) {(models:$0,location:$1)}
            .map ({ arg in
                arg.models.compactMap({AirportCellViewModel(
                    usingModel: $0,
                    currentLocation: arg.location ?? (lat:0,lon:0))
                    
                    }).sorted() 
                
            })
            .map({[AirportItemsSection(model: 0, items: $0)]})
            .asDriver(onErrorJustReturn: [])
                
        return (
            title : Driver.just(dependancies.title),
            airports : sections
             
        )
    }
}


extension AirportCellViewModel : Comparable {
    static func < (lhs: AirportCellViewModel, rhs: AirportCellViewModel) -> Bool {
          return lhs.distance ?? 0 < rhs.distance ?? 0
    }
    
    static func == (lhs: AirportCellViewModel, rhs: AirportCellViewModel) -> Bool {
         return lhs.code == rhs.code
    }
}

