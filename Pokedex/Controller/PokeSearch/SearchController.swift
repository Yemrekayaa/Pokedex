//
//  SearchController.swift
//  Pokedex
//
//  Created by Yunus Emre Kaya on 9.08.2022.
//

import UIKit
import SnapKit
class SearchController: UIViewController {
    
    
    // MARK: - PokedexController
    weak var pokedexController: PokedexController?{
        didSet{
            typeCollectionViewController.pokedexController = pokedexController
            typeCollectionViewController.searchController = self
        }
    }
    
    // MARK: - Search Bar Views
    lazy var searchBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .MyTheme.primaryColor
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.MyTheme.primaryBorderColor.cgColor
        view.addSubview(searchBar)
        view.addSubview(searchBarLabel)
        view.layer.masksToBounds = true
        return view
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = true
        searchBar.searchBarStyle = .default
        searchBar.placeholder = "Pokemon Name..."
        searchBar.showsCancelButton = false
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        searchBar.barTintColor = .MyTheme.primaryColor
        searchBar.searchTextField.backgroundColor = .white
        searchBar.layer.cornerRadius = 10
        return searchBar
    }()
    
    let searchBarLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    
    // MARK: - Type Views
    lazy var typeSearchView: UIView = {
        let view = UIView()
        view.backgroundColor = .MyTheme.primaryColor
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.MyTheme.primaryBorderColor.cgColor
        view.addSubview(typeLabel)
        view.addSubview(typeCollectionViewController.view)
        return view
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.text = "Types"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let typeCollectionViewController: TypeCollectionViewController = {
        let layout = UICollectionViewFlowLayout()
        let view = TypeCollectionViewController(collectionViewLayout: layout)
        return view
    }()
    
    
    // MARK: - Clear Button
    let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setAttributedTitle(NSAttributedString(string: "Clear", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont(name: "MarkerFelt-Thin", size: 16)!]), for: .normal)
        button.backgroundColor = .MyTheme.primaryColor
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.MyTheme.primaryBorderColor.cgColor
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .MyTheme.secondaryColor
        navigationItem.title = "Search"
        searchBar.delegate = self
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        setupView()
        view.addBorder(toSide: .top, withColor: UIColor.MyTheme.primaryBorderColor.cgColor, andThickness: 1)
        view.addBorder(toSide: .right, withColor: UIColor.MyTheme.primaryBorderColor.cgColor, andThickness: 1)
    }
    
    // MARK: - Setup View
    private func setupView(){
        view.addSubview(searchBarView)
        searchBarView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().offset(8).inset(8)
            make.top.equalToSuperview().offset(12)
            make.height.equalTo(60)
        }
        
        searchBarLabel.snp.makeConstraints { make in
            make.trailing.leading.top.equalToSuperview()
            make.height.equalTo(30)
        }
        searchBar.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.top.equalTo(searchBarLabel.snp.bottom)
            make.bottom.equalToSuperview()
        }
        searchBar.searchTextField.snp.makeConstraints { make in
            make.trailing.leading.top.bottom.equalToSuperview()
        }
        
        view.addSubview(typeSearchView)
        typeSearchView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().offset(8).inset(8)
            make.top.equalTo(searchBarView.snp.bottom).offset(8)
            make.height.equalTo(450)
        }
        typeLabel.snp.makeConstraints { make in
            make.trailing.leading.top.equalToSuperview()
            make.height.equalTo(30)
        }
        typeCollectionViewController.view.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.top.equalTo(typeLabel.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
        
        view.addSubview(clearButton)
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        clearButton.addTarget(self, action: #selector(clearButtonTouchDown), for: .touchDown)
        clearButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().offset(8).inset(8)
            make.top.equalTo(typeSearchView.snp.bottom).offset(8)
            make.height.equalTo(40)
        }
    }
    
}

// MARK: - Search Settings
extension SearchController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchString = searchBar.text,
              let pokedexController = pokedexController else {return}
        if(pokedexController.typeFilterPokemon.isEmpty){
            pokedexController.list = pokedexController.allPokemon
        }else{
        pokedexController.list = pokedexController.typeFilterPokemon
        }
        if searchString.count > 1 {
            pokedexController.list = pokedexController.list.filter({ poke in
                if let name = poke.name?.lowercased(), name.contains(searchString.lowercased()){
                    return true
                }
                return false
            })
        }
        
    }
    
    @objc func clearButtonTapped(_ sender: UIButton){
        sender.backgroundColor = .MyTheme.primaryColor
        pokedexController!.list = pokedexController!.allPokemon
        pokedexController!.typeFilterPokemon = pokedexController!.allPokemon
        searchBar.text = ""
        typeCollectionViewController.collectionView.reloadData()
    }
    @objc func clearButtonTouchDown(_ sender: UIButton){
        sender.backgroundColor = .MyTheme.secondaryColor
    }
    
    
}
