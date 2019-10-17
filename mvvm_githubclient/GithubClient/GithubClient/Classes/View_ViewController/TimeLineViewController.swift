//
//  TimeLineViewController.swift
//  GithubClient
//
//  Created by kazuya on 2019/10/16.
//  Copyright © 2019 K.Hatano. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

/**
 - UserListViewModelから通知を受け取り, tableViewを更新する
 - UserListViewModelの保持するUserVellViewModelから通知を受け取り
    画像を更新する
    Cellに必要なUserCellViewModelのアウトプットをCellにセットする
 - Cellを選択したらそのユーザーのGithubページに遷移する
 */
class TimeLineViewController: UIViewController {
    
    fileprivate var viewModel: UserListViewModel!
    fileprivate var tableView: UITableView!
    fileprivate var refreshControl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TimeLineCell.self, forCellReuseIdentifier: "TimeLineCell")
        view.addSubview(tableView)
        
        // UIRefreshControlを生成し、リフレッシュした時に呼ばれるメソッドを定義し
        // tableView.refreshControlにセットする
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlValueDidChange(sender:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        // UserListViewModelを生成し、通知を受け取った時の処理を定義
        viewModel = UserListViewModel()
        viewModel.stateDidUpdate = {[weak self] state in
            switch state {
            case .loading:
                // 通信中だったら tableViewを操作不能にする
                self?.tableView.isUserInteractionEnabled = false
                break
            case .finish:
                // 通信が完了したらtableViewを操作可能にし tableViewを更新
                // また, refreshControl.endRefreshingをcall
                self?.tableView.isUserInteractionEnabled = true
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
                break
            case .error(let error):
                // tableViewを操作可能にし refreshControl.endRefreshingをcall
                self?.tableView.isUserInteractionEnabled = true
                self?.refreshControl.endRefreshing()
                
                let alertController = UIAlertController(title: error.localizedDescription,
                                                        message: nil,
                                                        preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(alertAction)
                self?.present(alertController, animated: true, completion: nil)
                break
            }
        }
        
        // ユーザー一覧を取得する
        viewModel.getUsers()
    }
    
    @objc func refreshControlValueDidChange(sender: UIRefreshControl) {
        // リフレッシュした時、ユーザー一覧を取得する
        viewModel.getUsers()
    }
}

extension TimeLineViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.usersCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let timelineCell = tableView.dequeueReusableCell(withIdentifier: "TimeLineCell") as? TimeLineCell {
            // CellのUserCellViewModelを取得し
            // timelineCellに対して nickName, iconをセット
            let cellViewModel = viewModel.cellViewModels[indexPath.row]
            timelineCell.setNickName(nickName: cellViewModel.nicName)
            
            cellViewModel.downloadImage() { (progress) in
                switch progress {
                case .loading(let image):
                    timelineCell.setIcon(icon: image)
                    break
                case .finish(let image):
                    timelineCell.setIcon(icon: image)
                    break
                case .error:
                    break
                }
            }
           
            return timelineCell
        }
        
        fatalError()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // そのCellのUserViewModelを取得しそのユーザーのGithubページに画面遷移する
        let cellViewModel = viewModel.cellViewModels[indexPath.row]
        let webURL = cellViewModel.webURL
        let webViewController = SFSafariViewController(url:webURL)
        navigationController?.pushViewController(webViewController, animated: true)
    }
}
