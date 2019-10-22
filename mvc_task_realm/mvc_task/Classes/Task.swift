//
//  Task.swift
//  mvc_task
//
//  Created by kazuya on 2019/10/03.
//  Copyright © 2019 K.Hatano. All rights reserved.
//

import Foundation
import RealmSwift

/**
    Taskを管理するクラス
*/
final class Task: Object {
    @objc dynamic var id: String!
    @objc dynamic var text: String!    // タスクの内容
    @objc dynamic var deadline: Date! // タスクの締め切り時間
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init (id: String, text: String, deadline: Date) {
        self.init()
        self.id = id
        self.text = text
        self.deadline = deadline
    }
}
