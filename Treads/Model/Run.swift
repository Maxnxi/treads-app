//
//  Run.swift
//  Treads
//
//  Created by Maksim Ponomarev on 12.11.2020.
//

import Foundation
import RealmSwift

class Run: Object {
    @objc dynamic public private(set) var id = ""
    @objc dynamic public private(set) var date = NSDate()
    @objc dynamic public private(set) var pace = 0
    @objc dynamic public private(set) var distance = 0.0
    @objc dynamic public private(set) var duration = 0
    
    override class func primaryKey() -> String {
        return "id"
    }
    
    override class func indexedProperties() -> [String] {
        return ["pace", "date", "duration"]
    }
    
    convenience init(pace: Int, distance: Double, duration: Int) {
        self.init()
        self.id = UUID().uuidString.lowercased()
        
        self.date = NSDate()
        self.pace = pace
        self.distance = distance
        self.duration = duration
        
    }
    
//    func addRunToRealm() {
//            do {
//                let realm = try Realm()
//                try realm.write {
//                    realm.add(self)
//                    try realm.commitWrite()
//                }
//            } catch {
//                debugPrint("Error Saving to Realm; \(error.localizedDescription)")
//            }
//        }
    static func addRunToRealm(pace:Int, distance: Double, duration: Int) {
        REALM_QUEUE.sync {
        let run = Run(pace: pace, distance: distance, duration: duration)
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(run)
                try realm.commitWrite()
                print("Succes\nwriting to realm")
            }

        } catch {
            debugPrint("Error adding to realm.\n\(error.localizedDescription)")
        }
        }

    }
    
    static func getAllRuns() -> Results<Run>? {
        do {
            let realm = try Realm()
            var runs = realm.objects(Run.self)
            runs = runs.sorted(byKeyPath: "date", ascending: false)
            return runs
        }catch{
            debugPrint("Error getAllRuns")
            return nil
        }
    }
}


