//
//  TaskDataSource.swift
//  mvc_task
//
//  Created by kazuya on 2019/10/03.
//  Copyright © 2019 K.Hatano. All rights reserved.
//

import UIKit

class TaskDataSource: NSObject {

    // Task一覧を保持するArray UITableViewに表示させるデータ
    private var tasks = [Task]()

    /**
        UserDefaultsから保存したTask一覧を読み込む
    */
    func loadData() {
        let userDefaults = UserDefaults.standard
        let taskDictionaries = userDefaults.object(forKey: "tasks") as? [[String: Any]]

        guard let t = taskDictionaries else {
            return
        }

        for dict in t {
            let task = Task(from: dict)
            tasks.append(task)
        }
    }

    /**
        TaskをUserDefaultsに保存する
    */
    func save(task: Task) {
        tasks.append(task)

        var taskDictionaries = [[String: Any]]()
        for t in tasks {
            let taskDictionary: [String: Any] = ["task": t.text, "deadline": t.deadline]
            taskDictionaries.append(taskDictionary)
        }

        let userDefaults = UserDefaults.standard
        userDefaults.set(taskDictionaries, forKey:"tasks")
        userDefaults.synchronize()
    }

    /**
        Taskの数を返す
    */
    func count() -> Int {
        return tasks.count
    }

    /**
        指定したindexのTaskを返す
    */
    func data(at index: Int) -> Task? {
        if tasks.count > index {
            return tasks[index]
        }

        return nil
    }


}
