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
  
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete", handler: { (action, view, success) in
            
                self.removeGoal(atIndexPath: indexPath)
                self.fetchCoreeDataObjects()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                print("Successfully Deleted goal")
            
          })
          deleteAction.backgroundColor = .red
        let addProgressAction = UIContextualAction(style: .normal, title: "Add +1") { (action, view, success) in
            self.setProgressForGoal(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
            print("\n Successfully add progress to goal: \(String(describing: self.goals[indexPath.row].goalDesription))")
            
            let alert  = UIAlertController(title: "Done! ", message: "Progress added" ,preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK ", style: .default, handler: nil)
                    alert.addAction(okAction)
                    alert.popoverPresentationController?.sourceView = self.view //
                    self.present(alert, animated: true, completion: nil)
        }
        deleteAction.image = UIImage(named: "Trash")
        deleteAction.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        addProgressAction.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
          return UISwipeActionsConfiguration(actions: [deleteAction, addProgressAction])
    }
}



