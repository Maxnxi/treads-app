//
//  LogCell.swift
//  Treads
//
//  Created by Maksim Ponomarev on 10.11.2020.
//

import UIKit

class LogCell: UITableViewCell {

    @IBOutlet weak var miOfTotaldistanceLbl: UILabel!
    @IBOutlet weak var miOfAvgPaceLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var paceAvgLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configure(run: Run) {
        distanceLbl.text = "\(run.distance.metersToMiles(places: 2))"
        durationLbl.text = run.duration.formatTimeDurationToString()
        paceAvgLbl.text = run.pace.formatTimeDurationToString()
        dateLbl.text = run.date.getDateString()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        //super.setSelected(selected, animated: false)
//        isSelected = false
        

      
    }

}


