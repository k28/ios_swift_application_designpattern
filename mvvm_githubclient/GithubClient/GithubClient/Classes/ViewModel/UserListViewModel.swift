//
//  UserListViewModel.swift
//  GithubClient
//
//  Created by kazuya on 2019/10/14.
//  Copyright © 2019 K.Hatano. All rights reserved.
//

import Foundation
import UIKit

/**
 現在の状態
 */
enum ViewModelState {
    case loading
    case finish
    case error(Error)
}

/**
 - APIクラスからuserの配列を受ける
 - userの配列分だけUserCellViewModelを作成して保持する
 - 現在通信中か通信が成功/失敗の状態もちViewControllerに伝える(tableViewのを更新するかViewControllerが決定)
 - tableViewを表示するために必要なアウトプットをし出力する
 */
final class UserListViewModel {
    
    // ViewModelStateをClosureとしてpropertyを保持
    // この変数がViewControllerに対して通知を送る役割を果たす
    var stateDidUpdate:((ViewModelState) -> Void)?
    
    // userの配列
    private var users = [User]()
    
    // UserCellViewModelの配列
    var cellViewModels = [UserCellViewModel]()
    
    // Model層で定義したAPIクラスを変数として保持
    let api = API()
    
    // Userの配列を取得する
    func getUsers() {
        // .loading通知を送る
        stateDidUpdate?(.loading)
        users.removeAll()
        
        api.getUsers(success: { (users) in
            self.users.append(contentsOf: users)
            for user in users {
                // UserCellViewModelの配列を作成
                let userCellViewModel = UserCellViewModel(user: user)
                self.cellViewModels.append(userCellViewModel)
                
                // 通知がせ成功したので, .finishを送る
                self.stateDidUpdate?(.finish)
            }
            
        }, failure:{ (error) in
            // 通信が失敗したので. error通知を送る
            self.stateDidUpdate?(.error(error))
        })
    }

    // tableViewの表示に使う
    func usersCount() -> Int {
        return users.count
    }
}
