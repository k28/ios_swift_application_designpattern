//
//  User.swift
//  GithubClient
//
//  Created by kazuya on 2019/10/13.
//  Copyright © 2019 K.Hatano. All rights reserved.
//

import UIKit

final class User {
    let id: Int
    let name: String
    let iconUrl: String
    let webURL: String
    
    init(attributes: [String: Any]) {
        id = attributes["id"] as! Int
        name = attributes["login"] as! String
        iconUrl = attributes["avatar_url"] as! String
        webURL = attributes["html_url"] as! String
    }
}
