//
//  PokeCell.swift
//  Pokedex
//
//  Created by Yunus Emre Kaya on 6.08.2022.
//

import UIKit
import SnapKit

class PokeCell: UICollectionViewCell {
    
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .MyTheme.secondaryColor : .MyTheme.primaryColor
            //imageView.backgroundColor = isSelected ? .MyTheme.secondaryColor : .MyTheme.primaryColor
        }
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowOffset = CGSize(width: 0, height: -5)
        imageView.layer.shadowRadius = 0.5
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .systemGray6
        return imageView
    }()
    
    var typeImageViews = [UIImageView]()
    var types = [String]() {
        didSet{
            self.imageView.layer.shadowColor = UIColor.TypeColor.color[types[0].lowercased()]?.cgColor
            
            setupType()
        }
    }
    let typeStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .top
        view.spacing = 0
        
        return view
    }()
    
    
    lazy var nameView: UIView = {
        let view = UIView()
        view.backgroundColor = .MyTheme.secondaryColor
        view.addSubview(nameLabel)
        return view
    }()
    
    lazy var nameViewBorder: CALayer = {
        let border = CALayer()
        border.backgroundColor = UIColor.red.cgColor
        return border
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        label.font = UIFont(name: "MarkerFelt-Thin", size: 18)
        return label
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
        layer.borderWidth = 1
        layer.borderColor = UIColor.MyTheme.primaryBorderColor.cgColor
        clipsToBounds = true
        backgroundColor = .MyTheme.primaryColor
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.width.height.equalTo(self.frame.size.width/2)
        }
        
        
        addSubview(nameView)
        nameView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(10)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        addSubview(typeStack)
        typeStack.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalToSuperview().offset(10)
        }
        
    }
    
    private func setupType(){
        typeImageViews.removeAll()
        for view in typeStack.arrangedSubviews {
            view.removeFromSuperview()
        }
        for i in 0..<types.count{
            let typeImage = UIImageView()
            typeImage.image = UIImage(named: "type_\(types[i].uppercased())")
            typeImageViews.append(typeImage)
            typeStack.addArrangedSubview(typeImageViews[i])
            typeImageViews[i].snp.makeConstraints { make in
                make.width.equalToSuperview()
                make.height.equalTo(typeStack.frame.size.width / 2)
            }
        }
    }
    
    
}

