//
//  CurrentRunVC.swift
//  Treads
//
//  Created by Maksim Ponomarev on 11.11.2020.
//

import UIKit
import MapKit

class CurrentRunVC: LocationVC {

    @IBOutlet weak var sliderImageView: UIImageView!
    @IBOutlet weak var swipeBGImageView: UIImageView!
   
    @IBOutlet weak var pauseBtn: UIButton!
    
    @IBOutlet weak var timeLbl: UILabel!//duration lbl
    @IBOutlet weak var paceLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    
    var startLocation:CLLocation!
    var lastLocation: CLLocation!
    
    var runDistance = 0.0
    var timer = Timer()
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        manager?.delegate = self
        manager?.distanceFilter = 10
        startRun()
    }
    
    func startRun(){
        manager?.startUpdatingLocation()
        startTimer()
    }
    
    func stopRun() {
        manager?.stopUpdatingLocation()
    }
    
    func startTimer() {
        
        timeLbl.text = counter.formatTimeDurationToString()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateCounter() {
        counter += 1
        timeLbl.text = counter.formatTimeDurationToString()
    }
    
    func setupView(){
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(endRunSwiped(sender:)))
        sliderImageView.addGestureRecognizer(swipeGesture)
        sliderImageView.isUserInteractionEnabled = true
        swipeGesture.delegate = self as? UIGestureRecognizerDelegate
    }
    
    
    @IBAction func pauseBtnWasPressed(_ sender: Any) {
        
        
    }
    
    @objc func endRunSwiped(sender: UIPanGestureRecognizer){
        let minAdjust: CGFloat = 80
        let maxAdjust: CGFloat = 130
        if let sliderView = sender.view {
            if sender.state == UIGestureRecognizer.State.began || sender.state == UIGestureRecognizer.State.changed {
                let translation = sender.translation(in: self.view)
                if sliderView.center.x >= (swipeBGImageView.center.x - minAdjust) && sliderView.center.x <= (swipeBGImageView.center.x + maxAdjust) {
                    sliderView.center.x = sliderView.center.x + translation.x
//                    CGPoint(x: sliderView.center.x + translation.x, y: sliderView.center.y)
                } else if sliderView.center.x >= (swipeBGImageView.center.x + maxAdjust) {
                    sliderView.center.x = swipeBGImageView.center.x + maxAdjust
                    // end run code goes here
                    dismiss(animated: true, completion: nil)
                } else {
                    sliderView.center.x = swipeBGImageView.center.x - minAdjust
                }
                sender.setTranslation(CGPoint.zero, in: self.view)
            } else if sender.state == UIGestureRecognizer.State.ended {
                UIView.animate(withDuration: 0.1) {
                    sliderView.center.x = self.swipeBGImageView.center.x - minAdjust
                }
                
            }
        }
    }

}

extension CurrentRunVC: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            checkLocationAuthStatus()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if startLocation == nil {
            startLocation = locations.first
        } else if let location = locations.last {
            runDistance += lastLocation.distance(from: location)
            //distanceLbl.text = "\(runDistance.metersToMiles(places: 2))"
            
            //Units of measure
            distanceLbl.text = "\(runDistance.metersToKilometers(places: 3))"
            print("\(runDistance)")
        }
        lastLocation = locations.last
    }
    
}

