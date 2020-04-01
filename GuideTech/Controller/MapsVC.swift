//
//  MapsVC.swift
//  GuideTech
//
//  Created by Valter A. Machado on 3/15/20.
//  Copyright © 2020 Valter A. Machado. All rights reserved.
//

import UIKit
import LBTATools
import MapKit
import CoreLocation

class MapsVC: UIViewController {
    
    var location = ""
//    let navController = UINavigationController()
    
    lazy var mapView: MKMapView = {
        let mp = MKMapView()
        mp.showsUserLocation = true
        mp.delegate = self
        mp.userLocation.title = "Me"
        mp.mapType = .mutedStandard
        return mp
    }()
    
    var locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        navController.delegate = self
        setupLocationManager()
        setupView()
        zoomInMap()
        getDirectionsFunc(location: location)
//        print("location: \(location)")
    }
    
    fileprivate func setupView(){
        [mapView].forEach({view.addSubview($0)})
        navigationController?.navigationBar.tintColor = .rgb(red: 101, green: 183, blue: 180)
        mapView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
    
    fileprivate func setupLocationManager(){
//        mapView.delegate = self
//        mapView.showsUserLocation = true
        //MARK: Setting LocationManager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
}

extension MapsVC: CLLocationManagerDelegate, MKMapViewDelegate {
    
    func getDirectionsFunc(location: String){
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(location) { (placeMarkers, error) in
            guard let placeMarkers = placeMarkers, let location = placeMarkers.first?.location else {
                print("No location")
                return
            }
            //            print(location)
            self.mapThis(destinationCoord: location.coordinate)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else {return}
//        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        let region = MKCoordinateRegion(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
//        mapView.setRegion(region, animated: false)
        print(locations)
    }
    
    fileprivate func zoomInMap(){
        let userLocation = (locationManager.location?.coordinate)!
        let region = MKCoordinateRegion(center: userLocation, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    
    fileprivate func mapThis(destinationCoord: CLLocationCoordinate2D){
        let userLocation = (locationManager.location?.coordinate)!
//        let region = MKCoordinateRegion(center: userLocation, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
//        mapView.setRegion(region, animated: true)
        
        let startingLocation = MKPlacemark(coordinate: userLocation)
        let destination = MKPlacemark(coordinate: destinationCoord)
        
        let sourceItem = MKMapItem(placemark: startingLocation)
        let desItem = MKMapItem(placemark: destination)
        
        let destinationRequest = MKDirections.Request()
        destinationRequest.source = sourceItem
        destinationRequest.destination = desItem
        destinationRequest.transportType = .automobile
        destinationRequest.requestsAlternateRoutes = true
        
        let directions = MKDirections(request: destinationRequest)
        directions.calculate { (response, error) in
            guard let response = response else {
                if let error = error {
                    print("something is really wrong! \(error)")
                }
                return
            }
            
            let route = response.routes[0]
            self.mapView.addOverlay(route.polyline)
            self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = .rgb(red: 101, green: 183, blue: 180)
        
        return render
    }
}
