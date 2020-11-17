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
    
    //last run View outlets
        @IBOutlet weak var lastRunInfoView: UIView!
        @IBOutlet weak var lastRunPaceLbl: UILabel!
        @IBOutlet weak var lastRunDistanceLbl: UILabel!
        @IBOutlet weak var lastRunDurationLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationAuthStatus()
        mapView.delegate = self
        printAllRuns()
        //lastRunInfoView.isHidden = true
        
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
        //printAllRuns()
        getLastRun()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        manager?.stopUpdatingLocation()
    }
    
    func getLastRun() {
        guard let lastRun = Run.getAllRuns()?.first else {
            
            lastRunInfoView.isHidden = true
            return
        }
        lastRunInfoView.isHidden = false
        lastRunPaceLbl.text = lastRun.pace.formatTimeDurationToString()
        lastRunDistanceLbl.text = "\(lastRun.distance.metersToMiles(places: 2)) mi"
        lastRunDurationLbl.text = lastRun.duration.formatTimeDurationToString()
        
    }
    
   
    @IBAction func closeLastRunBtnWasPressed(_ sender: Any) {
        lastRunInfoView.isHidden = true
    }
    
    
    @IBAction func settingsBtnWasPressed(_ sender: Any) {
        let settings = SettingsVC()
        settings.modalPresentationStyle = .fullScreen
        present(settings, animated: true, completion: nil)
        
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
