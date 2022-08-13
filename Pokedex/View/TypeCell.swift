//
//  TypeCell.swift
//  Pokedex
//
//  Created by Yunus Emre Kaya on 10.08.2022.
//

import UIKit

class TypeCell: UICollectionViewCell {
    
    
    
    override var isSelected: Bool{
        didSet{
            typeImageView.alpha = isSelected ? 1 : 0.5
        }
    }
    
    let typeImageView: UIImageView = {
        let iw = UIImageView()
        iw.contentMode = .scaleAspectFit
        iw.alpha = 0.5
        return iw
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        addSubview(typeImageView)
        typeImageView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}
