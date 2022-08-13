//
//  GroupBox.swift
//  Pokedex
//
//  Created by Yunus Emre Kaya on 13.08.2022.
//

import Foundation
import UIKit

class GroupBox: UIView{
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.textAlignment = .center
        label.backgroundColor = UIColor.MyTheme.secondaryColor
        label.layer.masksToBounds = true
        label.textColor = .white
        return label
    }()
    
    var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "Content"
        label.textAlignment = .center
        label.backgroundColor = .white
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .MyTheme.secondaryColor
        layer.masksToBounds = true
        layer.borderColor = UIColor.MyTheme.primaryBorderColor.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 10
        addSubview(titleLabel)
        titleLabel.snp.updateConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(30)
        }
       
        addSubview(contentLabel)
        contentLabel.snp.updateConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
