//
//  Storyboardable.swift
//  CityAirportSearch
//
//  Created by Shreya on 06/07/20.
//  Copyright © 2020 Shreya Pallan. All rights reserved.
//


/*
 Used to instantiate ViewControllers
 */

import Foundation

import UIKit


 protocol Storyboardable {
     static func instantiate() -> Self
 }

 extension Storyboardable where Self: UIViewController {
     static func instantiate() -> Self {
         // this pulls out "MyApp.MyViewController"
         let fullName = NSStringFromClass(self)

         // this splits by the dot and uses everything after, giving "MyViewController"
         let className = fullName.components(separatedBy: ".")[1]

         // load our storyboard
         let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

         // instantiate a view controller with that identifier, and force cast as the type that was requested
         return storyboard.instantiateViewController(withIdentifier: className) as! Self
     }
 }
