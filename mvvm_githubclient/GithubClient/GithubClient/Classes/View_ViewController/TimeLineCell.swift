//
//  TimeLineCell.swift
//  GithubClient
//
//  Created by kazuya on 2019/10/16.
//  Copyright © 2019 K.Hatano. All rights reserved.
//

import Foundation
import UIKit

class TimeLineCell: UITableViewCell {
    
    private var iconView: UIImageView!  // ユーザーのiconを表示させる
    private var nickNameLabel: UILabel!  // ユーザーのnicknameを表示させる
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        iconView = UIImageView()
        iconView.clipsToBounds = true
        contentView.addSubview(iconView)
        
        nickNameLabel = UILabel()
        nickNameLabel.font = UIFont.systemFont(ofSize: 15)
        contentView.addSubview(nickNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        iconView.frame = CGRect(x: 15, y: 15, width: 45, height: 45)
        // 角丸にする
        iconView.layer.cornerRadius = iconView.frame.size.width / 2
        
        nickNameLabel.frame = CGRect(x: iconView.frame.maxX + 15,
                                     y: iconView.frame.origin.y,
                                     width: contentView.frame.width - iconView.frame.maxX - (15 * 2),
                                     height: 15)
    }
    
    func setNickName(nickName: String) {
        nickNameLabel.text = nickName
    }
    
    func setIcon(icon: UIImage) {
        iconView.image = icon
    }
}
