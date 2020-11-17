//
//  SettingsVC.swift
//  Treads
//
//  Created by Maksim Ponomarev on 14.11.2020.
//

import UIKit

class SettingsVC: UIViewController {

    
    @IBOutlet weak var kilometersBtn: UIButton!
    @IBOutlet weak var mileBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    func setupView() {
        kilometersBtn.setDeSelectedColor()
        mileBtn.setSelectedColor()
        
    }
    
    func setKilometers(){
        
    }
    
    func setMiles(){
        
    }

    @IBAction func kilometersBtnWasPressed(_ sender: Any) {
        kilometersBtn.setSelectedColor()
        mileBtn.setDeSelectedColor()
        setKilometers()
    }
    
    @IBAction func milesBtnWasPressed(_ sender: Any) {
        mileBtn.setSelectedColor()
        kilometersBtn.setDeSelectedColor()
        setMiles()
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
    }
    
}
