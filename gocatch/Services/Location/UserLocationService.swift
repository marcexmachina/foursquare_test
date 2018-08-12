//
//  UserLocationService.swift
//  gocatch
//
//  Created by Marc O'Neill on 11/08/2018.
//  Copyright © 2018 marcexmachina. All rights reserved.
//

import CoreLocation

protocol LocationManager {
    var delegate: CLLocationManagerDelegate? { get set }
    func requestWhenInUseAuthorization()
    func startUpdatingLocation()
}

extension CLLocationManager: LocationManager {}

class UserLocationService: NSObject {

    private var locationManager: LocationManager

    init(locationManager: LocationManager, delegate: CLLocationManagerDelegate) {
        self.locationManager = locationManager
        super.init()
        self.locationManager.delegate = delegate
    }

    func getUserLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}
