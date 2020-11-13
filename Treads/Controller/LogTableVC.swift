//
//  LogTableVC.swift
//  Treads
//
//  Created by Maksim Ponomarev on 10.11.2020.
//

import UIKit
import Foundation

class LogTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var logTbaleView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logTbaleView.delegate = self
        logTbaleView.dataSource = self
        
        

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Run.getAllRuns()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = logTbaleView.dequeueReusableCell(withIdentifier: "logCell") as? LogCell {
            guard let run = Run.getAllRuns()?[indexPath.row] else {
                return LogCell()
            }
            cell.configure(run: run)
            return cell
        } else {
            debugPrint("Error fillng cell")
            return LogCell()
        }
    }
  

}



