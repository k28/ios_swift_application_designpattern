//
//  ImageDownloader.swift
//  GithubClient
//
//  Created by kazuya on 2019/10/14.
//  Copyright © 2019 K.Hatano. All rights reserved.
//

import Foundation
import UIKit

/**
    - 画像をダウンロードするリクエストを送る
    - 画像をダウンロードしたらキャッシュする
    - 画像のダウンロードに成功したら UIImageを返す
    - ErrorがあったらErrorを返す
*/
final class ImageDownloader {
    // UIImageをキャッシュする変数
    var cacheImage: UIImage?
    
    func downloadImage(imageURL: String,
                       succes:  @escaping (UIImage) -> Void,
                       failure: @escaping (Error) -> Void) {
        // キャッシュがあればそれを返す
        if let cacheImage = cacheImage {
            succes(cacheImage)
        }
        
        // リクエストを作成
        var request = URLRequest(url: URL(string: imageURL)!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request)
        { (data, response, error) in
            // Errorチェック
            if let error = error {
                DispatchQueue.main.async {
                    failure(error)
                }
                return
            }
            
            // dataチェック
            guard let data = data else {
                DispatchQueue.main.async {
                    failure(APIError.unknown)
                }
                return
            }
            
            // UIImageに変換できるか確認
            guard let imageFromData = UIImage(data: data) else {
                DispatchQueue.main.async {
                    failure(APIError.unknown)
                }
                return
            }
            
            // 画像を返す
            DispatchQueue.main.async {
                succes(imageFromData)
            }
            
            // 画像をキャッシュ
            self.cacheImage = imageFromData
        }
        
        task.resume()
    }
}
