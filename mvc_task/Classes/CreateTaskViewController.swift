//
//  CreateTaskViewController.swift
//  mvc_task
//
//  Created by kazuya on 2019/10/13.
//  Copyright © 2019 K.Hatano. All rights reserved.
//

import UIKit

class CreateTaskViewController: UIViewController {
    
    fileprivate var createTaskView: CreateTaskView!
    
    fileprivate var dataSource: TaskDataSource!
    fileprivate var taskText: String?
    fileprivate var taskDeadline: Date?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // CreateTaskViewを生成して、デリゲートに自分を設定
        createTaskView = CreateTaskView()
        createTaskView.delegate = self
        view.addSubview(createTaskView)
        
        // TaskDataSourceを生成
        dataSource = TaskDataSource()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // CreateTaskViewのレイアウトを決める
        createTaskView.frame = CGRect(x: view.safeAreaInsets.left,
                                      y: view.safeAreaInsets.top,
                                      width: view.frame.size.width - view.safeAreaInsets.left - view.safeAreaInsets.right,
                                      height: view.frame.size.height - view.safeAreaInsets.bottom)
    }
    
    /**
     保存が成功した時のアラート
     保存が成功したら、アラートを出し、前の画面に戻る
     */
    fileprivate func showSaveAlert() {
        let alertController = UIAlertController(title: "保存しました", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel) {
            (action) in
            _ = self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    /**
     タスクが未入力の時のアラート
     タスクが未入力の時に保存しない
     */
    fileprivate func showMissingTaskAlert() {
        let alertController = UIAlertController(title: "タスクを入力してください", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
   
    /**
     締切日が未入力の時のアラート
     締切日が未入力の時に保存しない
     */
    fileprivate func showMissingTaskDeadlineAlert() {
        let alertController = UIAlertController(title: "締切日を入力してください", message: nil, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension CreateTaskViewController: CreateTaskViewDelegate {
    
    func createView(taskEditing view: CreateTaskView, text: String) {
        // タスクの内容を入力中に呼ばれる
        taskText = text
    }
    
    func createView(deadlineEditing view: CreateTaskView, deadline: Date) {
        // 締切日を入力中に呼ばれる
        taskDeadline = deadline
    }
    
    func createView(saveButtonDidTap view: CreateTaskView) {
        // 保存ボタンが押された時に呼ばれるメソッド
        guard let taskText = taskText else {
            showMissingTaskAlert()
            return
        }
        guard let taskDeadline = taskDeadline else {
            showMissingTaskDeadlineAlert()
            return
        }
        
        let task = Task(text: taskText, deadline: taskDeadline)
        dataSource.save(task: task)
        
        showSaveAlert()
    }
}
