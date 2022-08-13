//
//  TypeCollectionViewController.swift
//  Pokedex
//
//  Created by Yunus Emre Kaya on 10.08.2022.
//

import UIKit

private let reuseIdentifier = "TypeCell"

class TypeCollectionViewController: UICollectionViewController {
    
    weak var pokedexController: PokedexController!
    weak var searchController: SearchController!
    let types = ["BUG","DARK","DRAGON","ELECTRIC","FAIRY","FIGHTING","FIRE","FLYING","GHOST","GRASS","GROUND","ICE","NORMAL","POISON","PSYCHIC","ROCK","STEEL","WATER"]
    
    var selectedTypes: String? {
        didSet{
            filterType()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(TypeCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .white
        collectionView.allowsMultipleSelection = false
        collectionView.layer.cornerRadius = 10
    }
    
    func filterType(){
        if ((selectedTypes?.isEmpty) != nil), selectedTypes != "" {
            PokeService.shared.fetchTypePokemon(with: selectedTypes!) { pokes in
                self.pokedexController.list = pokes
                self.pokedexController.typeFilterPokemon = pokes
                self.searchController.searchBar(self.searchController.searchBar, textDidChange: self.searchController.searchBar.text!)
            }
        }else{
            self.pokedexController.typeFilterPokemon = []
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return types.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TypeCell
        cell.typeImageView.image = UIImage(named: "type_\(types[indexPath.item])")
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedTypes = types[indexPath.item]
    }
    

    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let isSelectedAlready = collectionView.indexPathsForSelectedItems?.contains(indexPath)
        if isSelectedAlready == true {
            collectionView.deselectItem(at: indexPath, animated: true)
            collectionView.delegate?.collectionView?(collectionView, didDeselectItemAt: indexPath)
            return false
        }
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
       selectedTypes = nil
        searchController.searchBar(searchController.searchBar, textDidChange: searchController.searchBar.text!)
    }
}

extension TypeCollectionViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard var width = view.superview?.frame.width else {
            return CGSize()
        }
        width -= 26
        return CGSize(width: width/2, height: width/4)
    }
}
