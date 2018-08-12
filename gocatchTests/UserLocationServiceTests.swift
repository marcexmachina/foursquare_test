//
//  UserLocationServicesTests.swift
//  gocatchTests
//
//  Created by Marc O'Neill on 11/08/2018.
//  Copyright © 2018 marcexmachina. All rights reserved.
//

import XCTest
import CoreLocation
@testable import gocatch

class UserLocationServiceTests: XCTestCase {

    class MockLocationManager: LocationManager {
        var calledRequestWhenInUseAuthorization: Bool = false
        var delegate: CLLocationManagerDelegate?

        func requestWhenInUseAuthorization() {
            calledRequestWhenInUseAuthorization = true
        }

        func requestLocation() {}
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testLocationManagerDelegate_GivenUserLocationService() {
        let locationManager = CLLocationManager()
        let userLocationService = UserLocationService(locationManager: locationManager)
        XCTAssert(locationManager.delegate === userLocationService, "LocationManager delegate incorrectly set")
    }

    func testShouldRequestPermissionIsCalled() {
        let locationManager = MockLocationManager()
        let userLocationService = UserLocationService(locationManager: locationManager)

        XCTAssertFalse(locationManager.calledRequestWhenInUseAuthorization)
        userLocationService.getUserLocation()
        XCTAssertTrue(locationManager.calledRequestWhenInUseAuthorization)
    }
}
