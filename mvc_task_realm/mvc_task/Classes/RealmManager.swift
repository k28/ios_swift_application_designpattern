//
//  RealmManager.swift
//  mvc_task
//
//  Created by kazuya on 2019/10/22.
//  Copyright © 2019 K.Hatano. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmManager {
    
    static func initialize() {
        let config = Realm.Configuration(
            schemaVersion: 2,
            migrationBlock: { migration, oldSchemaVersion in
                
        })
        
        Realm.Configuration.defaultConfiguration = config
    }
    
    static func getAllTasks() -> [Task] {
        do {
            let results = try Realm().objects(Task.self)
            
            if results.count == 0 {
                return []
            }
            
            var tasks = [Task]()
            for task in results {
                tasks.append(task)
            }
            
            return tasks
        } catch {
            return [Task]()
        }
    }
    
    static func updateTask(_ task: Task) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(task)
            }
        } catch {
        }
    }
}
