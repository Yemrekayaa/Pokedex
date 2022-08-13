//
//  EvoCell.swift
//  Pokedex
//
//  Created by Yunus Emre Kaya on 8.08.2022.
//

import UIKit

class DetailPokeCell: UICollectionViewCell {
    override var isSelected: Bool {
        didSet {
            layer.borderColor = isSelected ? UIColor.MyTheme.secondaryColor.cgColor : UIColor.MyTheme.primaryColor.cgColor
            imageView.backgroundColor = isSelected ? .systemGroupedBackground : .systemGray5
            imageView.alpha = isSelected ? 1 : 0.5
        }
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGroupedBackground
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0.5
        //imageView.image = UIImage(systemName: "person")
        return imageView
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        layer.cornerRadius = 10
        clipsToBounds = true
        backgroundColor = .systemGray5
        layer.cornerRadius = 10
        layer.borderColor = UIColor.MyTheme.primaryColor.cgColor
        layer.borderWidth = 6
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().offset(5).inset(5)
            make.right.left.equalToSuperview().offset(5).inset(5)
        }
        
        imageView.layer.cornerRadius = 10
    }
    
}
