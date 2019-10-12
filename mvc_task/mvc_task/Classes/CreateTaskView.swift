//
//  CreateTaskView.swift
//  mvc_task
//
//  Created by kazuya on 2019/10/12.
//  Copyright © 2019 K.Hatano. All rights reserved.
//

import UIKit

/**
    CreateTaskViewControllerへユーザーインタラクションを伝達するためのProtocol
*/
protocol CreateTaskViewDelegate: class {
    func createView(taskEditing view: CreateTaskView, text: String)
    func createView(deadlineEditing view: CreateTaskView, deadline: Date)
    func createView(saveButtonDidTap view: CreateTaskView)
}

class CreateTaskView: UIView {

    private var taskTextField: UITextField! // タスク内容を入力する
    private var datePicker: UIDatePicker!  // 締め切り時間を表示する
    private var deadlineTextField: UITextField! // 締め切り時間を入力する
    private var saveButton: UIButton!   // 保存ボタン

    weak var delegate: CreateTaskViewDelegate?    // デリゲート

    required override init(frame: CGRect) {
        super.init(frame: frame)

        taskTextField = UITextField()
        taskTextField.delegate = self
        taskTextField.tag = 0
        taskTextField.placeholder = "予定を入れてください"
        addSubview(taskTextField)

        deadlineTextField = UITextField()
        deadlineTextField.tag = 1
        deadlineTextField.placeholder = "期限を入れてください"
        addSubview(deadlineTextField)

        datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)

        // UITextFieldが編集モードになった時に、キーボードではなくUIDatePickerになるようにする
        deadlineTextField.inputView = datePicker
        
        saveButton = UIButton()
        saveButton.setTitle("保存する", for: .normal)
        saveButton.setTitleColor(UIColor.black, for: .normal)
        saveButton.layer.borderWidth = 0.5
        saveButton.layer.cornerRadius = 4.0
        saveButton.addTarget(self, action: #selector(saveButtonTrapped(_:)), for: .touchUpInside)
        addSubview(saveButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func saveButtonTrapped(_ sender: UIButton) {
        // Saveボタンが押された時に呼ばれる
        // 押した情報をCreateTaskViewControllerに伝達する
        delegate?.createView(saveButtonDidTap: self)
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        // UIDatePickerの値が切り替わった時にCallされる
        // sender.dateがユーザーが選択した締め切り, DateFormatterを使ってStringに変換する
        // 日時の情報はCreateTaskViewControllerに電番
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        let deadlineText = dateFormatter.string(from: sender.date)
        deadlineTextField.text = deadlineText
        delegate?.createView(deadlineEditing: self, deadline: sender.date)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        taskTextField.frame = CGRect(x: bounds.origin.x + 20, y: bounds.origin.y + 30, width: bounds.size.width - 60, height: 50)

        deadlineTextField.frame = CGRect(x: taskTextField.frame.origin.x, y: taskTextField.frame.maxY + 30, width: taskTextField.frame.size.width, height: taskTextField.frame.height)
        
        let saveButtonSize = CGSize(width: 100, height: 50)
        saveButton.frame = CGRect(x: (bounds.size.width - saveButtonSize.width), y: deadlineTextField.frame.maxY + 20, width: saveButtonSize.width, height: saveButtonSize.height)
    }

}

extension CreateTaskView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 0 {
            // タスクの内容
            delegate?.createView(taskEditing: self, text: textField.text ?? "")
        }
        
        return true
    }
    
}
