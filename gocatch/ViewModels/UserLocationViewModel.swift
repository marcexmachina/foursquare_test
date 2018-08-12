//
//  UserLocationViewModel.swift
//  gocatch
//
//  Created by Marc O'Neill on 12/08/2018.
//  Copyright © 2018 marcexmachina. All rights reserved.
//

import Foundation
import CoreLocation

struct UserLocationViewModel {

    var currentLocation: CLLocation?
    var locationService: UserLocationService

    init(locationService: UserLocationService) {
        self.locationService = locationService
        locationService.getUserLocation()
    }

}
