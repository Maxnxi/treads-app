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
    
    override func viewWillAppear(_ animated: Bool) {
        logTbaleView.reloadData()
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
  
    
    @IBAction func clearLogBtnWasPressed(_ sender: Any) {
        
        if Run.getAllRuns()!.count > 0 {
            Run.clearLogFromRealm()
            
            let alert = UIAlertController(title: "Info", message: "Run records deleted.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            alert.popoverPresentationController?.sourceView = self.view
            self.present(alert, animated: true, completion: nil)
            logTbaleView.reloadData()
        } else {
            let alert = UIAlertController(title: "Info", message: "No Run records in your Log.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            alert.popoverPresentationController?.sourceView = self.view
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
}



