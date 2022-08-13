//
//  PokemonController.swift
//  Pokedex
//
//  Created by Yunus Emre Kaya on 6.08.2022.
//

import UIKit
import JGProgressHUD
import PokemonAPI

class PokemonController: UIViewController {
    
    
    // MARK: Pokomon Collection View
    let pokemonCollectionView: PokemonCollectionViewController = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = PokemonCollectionViewController(collectionViewLayout: layout)
        return collection
    }()
    
    
    // MARK: - Types
    lazy var typeView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.MyTheme.primaryBorderColor.cgColor
        view.addSubview(typeStack)
        view.addSubview(typeLabel)
        return view
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.text = "Types"
        label.textAlignment = .center
        label.backgroundColor = UIColor.MyTheme.secondaryColor
        label.layer.masksToBounds = true
        label.textColor = .white
        return label
    }()
    
    let typeStack: UIStackView = {
        let view = UIStackView()
        view.layer.cornerRadius = 10
        view.axis = .horizontal
        view.alignment = .center
        view.spacing = 5
        
        return view
    }()
    
    var typeImages = [UIImageView]()
    
    // MARK: - Species
    let speciesBox: GroupBox = {
        let box = GroupBox()
        box.titleLabel.text = "Species"
        return box
    }()
    
    // MARK: - Egg Groups
    let eggGroupsBox: GroupBox = {
        let box = GroupBox()
        box.titleLabel.text = "Egg Groups"
        return box
    }()
    
    // MARK: - Desc
    
    let descText: UITextView = {
        let text = UITextView()
        text.font = UIFont(name: "MarkerFelt-Thin", size: 18)
        text.textAlignment = .center
        text.isEditable = false
        text.layer.cornerRadius = 10
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColor.MyTheme.primaryBorderColor.cgColor
        return text
    }()
    
    // MARK: - Evolution
    lazy var evoView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.MyTheme.primaryBorderColor.cgColor

        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        view.addSubview(evoLabel)
        view.addSubview(evoStack)
        return view
    }()
    
    let evoStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.spacing = 15
        return view
    }()
    
    let evoLabel: UILabel = {
        let label = UILabel()
        label.text = "Evolution"
        label.textAlignment = .center
        label.backgroundColor = UIColor.MyTheme.secondaryColor
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.textColor = .white
        return label
    }()
    
    // MARK: - About
    lazy var aboutView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.MyTheme.primaryBorderColor.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        view.addSubview(heightBox)
        view.addSubview(weightBox)
        return view
    }()
    
    let heightBox: GroupBox = {
        let box = GroupBox()
        box.titleLabel.text = "Height"
        return box
    }()
    let weightBox: GroupBox = {
        let box = GroupBox()
        box.titleLabel.text = "Weight"
        return box
    }()
    
    
    // MARK: - Spinner
    let spinner: JGProgressHUD = {
        let spinner = JGProgressHUD()
        spinner.vibrancyEnabled = true
        spinner.shadow = JGProgressHUDShadow(color: .MyTheme.primaryColor, offset: .zero, radius: 5, opacity: 1)
        spinner.interactionType = .blockAllTouches
        spinner.contentView.backgroundColor = .MyTheme.primaryColor
        spinner.contentView.alpha = 0.5
        spinner.contentView.layer.borderWidth = 0
        return spinner
    }()
    
    let rightLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 25))
        label.text = "###"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "MarkerFelt-Thin", size: 22)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.addBorder(toSide: .bottom, withColor: UIColor.MyTheme.primaryBorderColor.cgColor, andThickness: 3)
        return label
    }()
    
    var pokemon: Pokemon? {
        didSet{
            self.updatePokemon()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonCollectionView.pokemonController = self
        setupView()
        setupGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.addBorder(toSide: .bottom, withColor: UIColor.MyTheme.primaryBorderColor.cgColor, andThickness: 1)
        pokemonCollectionView.view.addBorder(toSide: .bottom, withColor: UIColor.MyTheme.primaryBorderColor.cgColor, andThickness: 1)
    }
    
    // MARK: - Setup View
    private func setupView(){
        view.backgroundColor = .MyTheme.primaryColor
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightLabel)
        view.addSubview(pokemonCollectionView.view)
        pokemonCollectionView.view.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(170)
        }

        view.addSubview(descText)
        descText.snp.makeConstraints { make in
            make.top.equalTo(pokemonCollectionView.view.snp.bottom).offset(8)
            make.trailing.leading.equalToSuperview().offset(20).inset(20)
            make.height.equalTo(100)
        }
        
        view.addSubview(typeView)
        typeView.snp.makeConstraints { make in
            make.top.equalTo(descText.snp.bottom).offset(10)
            make.trailing.leading.equalToSuperview().offset(20).inset(20)
            make.height.equalTo(70)
        }

        typeLabel.snp.makeConstraints { make in
            make.top.trailing.leading.equalToSuperview()
            make.height.equalTo(30)
        }
        
        typeStack.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalTo(view.snp.centerX)
        }
        
        view.addSubview(speciesBox)
        speciesBox.snp.makeConstraints { make in
            make.top.equalTo(typeView.snp.bottom).offset(10)
            make.trailing.leading.equalToSuperview().offset(20).inset(20)
            make.height.equalTo(70)
        }
        
        view.addSubview(eggGroupsBox)
        eggGroupsBox.snp.makeConstraints { make in
            make.top.equalTo(speciesBox.snp.bottom).offset(10)
            make.trailing.leading.equalToSuperview().offset(20).inset(20)
            make.height.equalTo(70)
        }
        
        view.addSubview(evoView)
        
        evoView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(30)
            make.trailing.leading.equalToSuperview().offset(20).inset(20)
            make.height.equalTo(150)
        }
        evoStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
        }
        evoLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(30)
            make.top.equalToSuperview()
        }
        view.addSubview(aboutView)
        aboutView.snp.makeConstraints { make in
            make.top.equalTo(eggGroupsBox.snp.bottom).offset(10)
            make.bottom.lessThanOrEqualTo(evoView.snp.top)
            make.leading.trailing.equalToSuperview().offset(20).inset(20)
        }
        heightBox.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalTo(aboutView.snp.centerX).inset(10)
            make.height.equalTo(70)
            make.top.equalToSuperview()
        }
        weightBox.snp.makeConstraints { make in
            make.left.equalTo(aboutView.snp.centerX).offset(10)
            make.right.equalToSuperview()
            make.height.equalTo(70)
            make.top.equalToSuperview()
        }
        
        
    }
    
    
    func setupEvo(){
        guard let family = pokemon?.first?.family else {return}
        for subview in evoStack.subviews{
            subview.removeFromSuperview()
        }
        for i in 0..<family.evolutionLine!.count{
            let view = UIView()
            view.layer.borderColor = UIColor.MyTheme.primaryColor.cgColor
            view.layer.borderWidth = 5
            view.layer.cornerRadius = 10
            let imageView = UIImageView()
            view.addSubview(imageView)
            evoStack.addArrangedSubview(view)
            PokeService.shared.fetchPokemon(with: family.evolutionLine![i]) { poke in
                imageView.sd_setImage(with: try! poke.first!.sprite?.asURL())
            }
            if family.evolutionStage == (i + 1) {
                view.layer.borderColor = UIColor.MyTheme.secondaryColor.cgColor
            }
            view.snp.makeConstraints { make in
                make.width.height.equalTo(100)
            }
            imageView.snp.makeConstraints { make in
                make.centerX.centerY.equalToSuperview()
                make.width.height.equalToSuperview().offset(10).inset(10)
            }
            
        }
    }
    
    // MARK: - Setup Types
    private func setupTypes(){
        typeImages.removeAll()
        for view in typeStack.arrangedSubviews {
            view.removeFromSuperview()
        }
        guard let types = pokemon?.first?.types else {return}
        for i in 0..<types.count{
            let image = types[i].uppercased()
            let typeImage = UIImageView()
            typeImage.image = UIImage(named: "type_\(image)")
            typeImages.append(typeImage)
            typeStack.addArrangedSubview(typeImages[i])
            typeImages[i].widthAnchor.constraint(equalToConstant: 80).isActive = true
            typeImages[i].heightAnchor.constraint(equalToConstant: 40).isActive = true
        }
        
    }
    // MARK: - Swipe Gesture
    private func setupGesture(){
        let nextPoke = UISwipeGestureRecognizer(target: self, action: #selector(swipe(gesture:)))
        nextPoke.direction = .left
        self.view.addGestureRecognizer(nextPoke)
        
        let previousPoke = UISwipeGestureRecognizer(target: self, action: #selector(swipe(gesture:)))
        previousPoke.direction = .right
        self.view.addGestureRecognizer(previousPoke)
    }
    
    @objc func swipe(gesture: UISwipeGestureRecognizer){
        guard let indexPath = pokemonCollectionView.collectionView.indexPathsForSelectedItems?[0] else {return}
        if gesture.direction == .left, indexPath.item != pokemonCollectionView.collectionView.numberOfItems(inSection: 0) - 1{
            DispatchQueue.main.async {
                self.pokemonCollectionView.collectionView.selectItem(at: IndexPath(item: indexPath.item + 1, section: 0), animated: true, scrollPosition: .centeredHorizontally)
                self.pokemonCollectionView.collectionView(self.pokemonCollectionView.collectionView, didSelectItemAt: IndexPath(item: indexPath.item + 1, section: 0))
            }
        }
        if gesture.direction == .right, indexPath.item != 0{
            DispatchQueue.main.async {
                self.pokemonCollectionView.collectionView.selectItem(at: IndexPath(item: indexPath.item - 1, section: 0), animated: true, scrollPosition: .centeredHorizontally)
                self.pokemonCollectionView.collectionView(self.pokemonCollectionView.collectionView, didSelectItemAt: IndexPath(item: indexPath.item - 1, section: 0))
            }
        }
    }
    
    // MARK: - Update UI
    private func updatePokemon(){
        guard let pokemon = pokemon?.first else {return}
        spinner.show(in: self.view)
        title = "\(pokemon.name!.capitalized)"
        rightLabel.text = String(format: "#%03d", (pokemon.number! as! NSString).integerValue)
        let desc = pokemon.description
        self.descText.snp.updateConstraints { make in
            make.height.equalTo(self.calculatedHeight(for: desc!, width: self.view.frame.width - 40))
        }
        self.descText.text =  desc
        heightBox.contentLabel.text = pokemon.height
        weightBox.contentLabel.text = pokemon.weight
        speciesBox.contentLabel.text = pokemon.species
        eggGroupsBox.contentLabel.text?.removeAll()
        for eggGroup in pokemon.eggGroups! {
            eggGroupsBox.contentLabel.text! += eggGroup + " "
        }
        setupTypes()
        setupEvo()
        self.spinner.dismiss(animated: true)
    }
}

extension PokemonController {
    // MARK: - Calculate TextView Height
    func calculatedHeight(for text: String, width: CGFloat) -> CGFloat {
        let label = UITextView(frame: CGRect(x: 0, y: 0, width: width,
                                             height: .greatestFiniteMagnitude))
        label.font = UIFont(name: "MarkerFelt-Thin", size: 18)
        label.textAlignment = .center
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
}
