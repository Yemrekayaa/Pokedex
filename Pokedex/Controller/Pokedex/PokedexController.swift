//
//  PokedexController.swift
//  Pokedex
//
//  Created by Yunus Emre Kaya on 6.08.2022.
//

import UIKit
import SDWebImage
import PokemonAPI
import SideMenu

private let reuseIdentifier = "PokeCell"

class PokedexController: UIViewController {
    
    let collectionView =  UICollectionView(frame: .null, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    var allPokemon = [AllPokemon]()
    var typeFilterPokemon = [AllPokemon]()
    var list = [AllPokemon]() {
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                
            }
        }
    }
    
    // MARK: - Search Controller
    lazy var search: SideMenuNavigationController = {
        let searchVC = SearchController()
        let search = SideMenuNavigationController(rootViewController: searchVC)
        searchVC.pokedexController = self
        search.leftSide = true
        search.menuWidth = view.frame.width / 2
        search.presentingViewControllerUserInteractionEnabled = true
        search.dismissOnPresent = false
        search.title = "Search Pokemon"
        return search
    }()
    
    // MARK: - Title
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Pokedex"
        label.textColor = .white
        label.font = .init(name: "MarkerFelt-Thin", size: 22)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchAllPokemon()
        setupViewController()
    }
    
    private func fetchAllPokemon(){
        PokeService.shared.fetchAllPokemon { result in
            self.allPokemon = result
            self.list = result
        }
    }
    
    private func setupViewController(){
        collectionView.register(PokeCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.width.equalTo(view.frame.size.width)
            make.height.equalToSuperview()
        }
        collectionView.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.addBorder(toSide: .top, withColor: UIColor.MyTheme.primaryBorderColor.cgColor, andThickness: 1)
    }
    
    
    private func setupView(){
        
        navigationController?.navigationBar.barTintColor = .MyTheme.primaryColor
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(toggleSearchBar))
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.titleView = titleLabel
        SideMenuManager.default.leftMenuNavigationController = search
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        
        
        
        
    }
    
    @objc func toggleSearchBar(){
        present(search,animated: true)
    }
    
}


extension PokedexController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PokeCell
        cell.nameLabel.text = list[indexPath.item].name?.capitalized
        cell.imageView.sd_setImage(with: list[indexPath.item].imageUrl())
        PokeService.shared.fetchPokemon(with: list[indexPath.item].getId()!) { poke in
            cell.types = (poke.first?.types)!
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let PokeVC = PokemonController()
        PokeVC.pokemonCollectionView.pokedexContoller = self
        PokeVC.pokemonCollectionView.selectedPokemonListIndex = indexPath.item
        PokeService.shared.fetchPokemon(with: list[indexPath.item].getId()!) { poke in
            PokeVC.pokemon = poke
        }
        navigationController?.pushViewController(PokeVC, animated: true)
        self.search.dismiss(animated: false)
        
        
    }
    
}

extension PokedexController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 6, bottom: 6, right: 6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 30) / 2
        return CGSize(width: width, height: width - 36)
    }
}


extension PokedexController: SideMenuNavigationControllerDelegate{
    func sideMenuDidAppear(menu: SideMenuNavigationController, animated: Bool) {
        collectionView.snp.updateConstraints { make in
            make.width.equalTo(view.frame.size.width / 2)
        }
        titleLabel.text = ""
        
        
    }
    
    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        collectionView.snp.updateConstraints { make in
            make.width.equalTo(view.frame.size.width)
        }
        titleLabel.text = "Pokedex"
    }
}

