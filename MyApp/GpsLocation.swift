//
//  GpsLocation.swift
//  Pantry
//
//  Created by 041312874 on 13/10/2015.
//  Copyright (c) 2015 Shiva Narrthine. All rights reserved.
//

import Foundation
class GpsLocation {
    if CLLocationManager.locationServicesEnabled() {
    switch(CLLocationManager.authorizationStatus()) {
    case .NotDetermined, .Restricted, .Denied:
    println("No access")
    case .AuthorizedAlways, .AuthorizedWhenInUse:
    println("Access")
    default:
    println("...")
    }
    } else {
    println("Location services are not enabled")
    }
}

