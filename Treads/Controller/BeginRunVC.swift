//
//  BeginRunVC.swift
//  Treads
//
//  Created by Maksim Ponomarev on 10.11.2020.
//
import Foundation
import UIKit
import MapKit

class BeginRunVC: LocationVC, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var centerLocationBtn: UIButton!
    @IBOutlet weak var startRunBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationAuthStatus()
        mapView.delegate = self
        printAllRuns()
        
    }
    
    func printAllRuns() {
        if Run.getAllRuns()!.count > 0 {
            print("Here are my runs:\n \(Run.getAllRuns())")
        } else {
            print("There is no run information")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        manager?.delegate = self
        manager?.startUpdatingLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        manager?.stopUpdatingLocation()
    }
    
   
    

    @IBAction func startRunBtnWasPressed(_ sender: Any) {
    }
    

    @IBAction func centerLocationBtnWasPressed(_ sender: Any) {
    }
}

extension BeginRunVC {
    
    // Old way func
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//
//    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        if manager.authorizationStatus == .authorizedWhenInUse {
            checkLocationAuthStatus()
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
        }
            
        
    }
}
