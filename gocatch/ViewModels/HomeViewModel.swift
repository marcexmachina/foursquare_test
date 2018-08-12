//
//  HomeViewModel.swift
//  gocatch
//
//  Created by Marc O'Neill on 11/08/2018.
//  Copyright © 2018 marcexmachina. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa

class HomeViewModel: NSObject, CLLocationManagerDelegate {

    private var locationService: UserLocationService?

    let searchText = Variable<String?>("")
    let placeHolderSearchText = Variable<String?>("What would you like to search for?")
    var mapCenter: CLLocationCoordinate2D? {
        didSet {
            onChangeMapCenter?()
        }
    }

    var onChangeMapCenter: (() -> Void)?

    var isValid: Observable<Bool> {
        return searchText
            .asObservable()
            .map { ($0 ?? "").count > 0 }
    }

    init(locationManager: LocationManager) {
        super.init()
        locationService = UserLocationService(locationManager: locationManager, delegate: self)
    }

    func getUserLocation() {
        locationService?.getUserLocation()
    }

    // MARK: - CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.mapCenter = locations.last?.coordinate
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
