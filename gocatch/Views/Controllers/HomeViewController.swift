//
//  ViewController.swift
//  gocatch
//
//  Created by Marc O'Neill on 10/08/2018.
//  Copyright © 2018 marcexmachina. All rights reserved.
//

import UIKit
import MapKit
import RxCocoa
import RxSwift

class HomeViewController: UIViewController {

    private var homeViewModel = HomeViewModel(locationManager: CLLocationManager())
    private let mapView = MKMapView()
    private let searchButton = UIButton(type: .roundedRect)
    private let searchTextField = UITextField()
    private let disposeBag = DisposeBag()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        homeViewModel.getUserLocation()
        setupUserInterface()
        setupBindings()
    }

    // MARK: Private Methods

    private func setupUserInterface() {
        let margins = view.layoutMarginsGuide
        view.addSubview(mapView)
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        setupMapView(margins)
        setupSearchTextField(margins)
        setupSearchButton(margins)
    }

    private func setupMapView(_ margins: UILayoutGuide) {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsUserLocation = true
        mapView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.75).isActive = true
    }

    private func setupSearchTextField(_ margins: UILayoutGuide) {
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.placeholder = "Coffee? Pizza?"
        searchTextField.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        searchTextField.bottomAnchor.constraint(equalTo: searchButton.topAnchor, constant: -20).isActive = true
        searchTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }

    private func setupSearchButton(_ margins: UILayoutGuide) {
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.setTitle("Search", for: .normal)
        searchButton.titleLabel?.text = "Search"
        searchButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -20).isActive = true
        searchButton.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }

    private func setupBindings() {
        homeViewModel.onChangeMapCenter = { [weak self] in
            guard let centerCoordinate = self?.homeViewModel.mapCenter else { return }
            let region = MKCoordinateRegionMakeWithDistance(centerCoordinate, 500, 500)
            self?.mapView.setRegion(region, animated: true)
        }

        // To  viewmodel
        searchTextField.rx.text.bind(to: homeViewModel.searchText).disposed(by: disposeBag)

        // From ViewModel
        homeViewModel.isValid
            .bind(to: searchButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }


}

