//
//  UserCellViewModel.swift
//  GithubClient
//
//  Created by kazuya on 2019/10/14.
//  Copyright © 2019 K.Hatano. All rights reserved.
//

import Foundation
import UIKit

enum ImageDownloadProgress {
    case loading(UIImage)
    case finish(UIImage)
    case error
}

/**
    - ImageDownloaderからユーザーのiconをダウンロードする
    - Image状態の通知を送る(ダウンロード中, ダウンロード終了, エラー)
    - ダウンロード中はグレーのImageをアウトプットする
    - Cellの見た目に反映させるアウトプットをする
*/
final class UserCellViewModel {
    private var user: User
    private let imageDownloader = ImageDownloader()
    private var isLoading = false
    
    // Cellに反映させるアプトプット
    var nicName: String {
        return user.name
    }
    
    // Cellを選択した時に必要なURL
    var webURL: URL {
        return URL(string: user.webURL)!
    }
    
    init(user: User) {
        self.user = user
    }
    
    // imageDownloaderを使ってダウンロードし、結果をImageDownloadProgressとしてClosureで返す
    func downloadImage(progress: @escaping (ImageDownloadProgress) -> Void) {
        if isLoading {
            return
        }
        isLoading = true
        
        // grayのImageを用意
        let loadingImage = UIImage(color: .gray, size: CGSize(width: 45.0, height: 45.0))!
        
        // ロード中の状態でClosureをcall
        progress(.loading(loadingImage))
        
        // imageDownloaderを用いて画像をダウンロードする
        imageDownloader.downloadImage(imageURL: user.iconUrl, succes: { (image) in
            progress(.finish(image))
            self.isLoading = false
        }, failure: { (error) in
            progress(.error)
            self.isLoading = false
        })
    }
}
