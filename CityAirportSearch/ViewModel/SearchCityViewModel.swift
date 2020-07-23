//
//  SearchCityViewModel.swift
//  CityAirportSearch
//
//  Created by Shreya on 05/07/20.
//  Copyright © 2020 Shreya Pallan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay
import RxDataSources



protocol SearchCityViewPresentable {
    typealias Input = (             //VC to VM
        searchText : Driver<String>,
        citySelect : Driver<CityViewModel>
    )
    typealias Output = (
        cities : Driver<[CityItemsSection]>,()
    )               //VM to VC
    
    typealias ViewModelBuilder = (SearchCityViewPresentable.Input) -> SearchCityViewPresentable
    
    var input : SearchCityViewPresentable.Input { get }         //get property of type Tuple to implement
    var output : SearchCityViewPresentable.Output { get }
  
}

class SearchCityViewModel : SearchCityViewPresentable {
    
    var input : SearchCityViewPresentable.Input
    var output : SearchCityViewPresentable.Output
    private let airportService : AirportAPI
    
    private let bag = DisposeBag()
    
    typealias State = (airports : BehaviorRelay<Set<AirportModel>>,())  // as replays last value
    private let state : State = (airports : BehaviorRelay<Set<AirportModel>>(value: []),())
    
    typealias RoutingAction = (citySelectedRelay : PublishRelay<Set<AirportModel>>,())
    lazy var routingAction : RoutingAction = (citySelectedRelay : PublishRelay(),())
    
    typealias Routing = (citySelected : Driver<Set<AirportModel>>,())
    lazy var router : Routing = (citySelected :
        routingAction.citySelectedRelay.asDriver(onErrorDriveWith: .empty()), () )
    
    
    
    
    init(input : SearchCityViewPresentable.Input, airportService : AirportAPI) {   //input - ??
        self.input = input
        self.output = SearchCityViewModel.output(input: self.input, state: self.state)
        self.airportService = airportService
        self.process()
    }
      
}

private extension SearchCityViewModel {
    
    static func output(input : SearchCityViewPresentable.Input,state:State) -> SearchCityViewPresentable.Output {
        
        let searchTextObservable = input.searchText.asObservable()
                .debounce(RxTimeInterval.milliseconds(300), scheduler: MainScheduler.instance)
                .distinctUntilChanged()
                .skip(1)
                .asObservable()
                .share(replay : 1, scope: .whileConnected )  // for cold and hot observal
        
        let airportsObservable = state.airports
            .skip(1)
            .asObservable()
            
        
        let sections = Observable.combineLatest(
            searchTextObservable,
            airportsObservable
             )
            .map ({ (searchKey, airports)  in
                
                return airports.filter { (airport) -> Bool in
                     !searchKey.isEmpty  &&
                        airport.city
                        .lowercased()
                        .replacingOccurrences(of: " ", with: "")
                        .hasPrefix(searchKey.lowercased())
                    
                }
                })
            .map ({
                    SearchCityViewModel.uniqueElementsFrom(array: $0.compactMap({
                        CityViewModel(model: $0)
                    }))
                })
            .map({ ([CityItemsSection(model: 0, items: $0)])                 
            })
            .asDriver(onErrorJustReturn: [])  // Data source created at this point. need to pas this data source to view controller
        return (
            cities: sections, ()
        )
    }
       
        
    
    
    func process() {
        self.airportService.fetchAirports()
            .map({ Set($0) })
            .map({ [state]  in state.airports.accept($0)
            })
        .subscribe()
        .disposed(by: bag)
        
        
        //handle tap event here
        self.input.citySelect
            .map ({$0.city})
            .withLatestFrom(state.airports.asDriver()) {($0,$1)}
            .map { (city, airports) in
                airports.filter({$0.city == city })
            }
           .map({  [routingAction] in
            
            routingAction.citySelectedRelay.accept($0)
           
            })
          .drive()
          .disposed(by:bag)
        
    }
    
}


private extension SearchCityViewModel {
     
    static func uniqueElementsFrom(array: [CityViewModel]) -> [CityViewModel] {
          //Create an empty Set to track unique items
          var set = Set<CityViewModel>()
          let result = array.filter {
            guard !set.contains($0) else {
              //If the set already contains this object, return false
              //so we skip it
              return false
            }
            //Add this item to the set since it will now be in the array
            set.insert($0)
            //Return true so that filtered array will contain this item.
            return true
          }
          return result
        }
}

