//
//  Task.swift
//  mvc_task
//
//  Created by kazuya on 2019/10/03.
//  Copyright © 2019 K.Hatano. All rights reserved.
//

import UIKit

/**
    Taskを管理するクラス
*/
class Task {
    let text: String    // タスクの内容
    let deadline: Date // タスクの締め切り時間

    /**
        引数からtextとdeadlineを受け取りTaskを生成する
    */
    init (text: String, deadline: Date) {
        self.text = text
        self.deadline = deadline
    }

    /**
        引数のdictionaryからTaskを生成する
        UserDefaukltsで保存したdictionaryから生成する事を目的としている
    */
    init(from dictionary: [String: Any]) {
        self.text = dictionary["task"] as! String
        self.deadline = dictionary["deadline"] as! Date
    }
}
