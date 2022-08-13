//
//  EvoChainController.swift
//  Pokedex
//
//  Created by Yunus Emre Kaya on 8.08.2022.
//

import UIKit
import PokemonAPI

private let reuseIdentifier = "DetailPokeCell"

class PokemonCollectionViewController: UICollectionViewController{
    
    
    weak var pokemonController: PokemonController?{
        didSet{
            updateCollectionView()
        }
    }
    weak var pokedexContoller: PokedexController?
    var selectedPokemonListIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(DetailPokeCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
    }
    
    
    func updateCollectionView(){
        DispatchQueue.main.async {
            self.collectionView(self.collectionView,didSelectItemAt: IndexPath(item: self.selectedPokemonListIndex!, section: 0))
            self.collectionView.selectItem(at: IndexPath(item: self.selectedPokemonListIndex!, section: 0), animated: false, scrollPosition: .centeredHorizontally)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (pokedexContoller?.list.count)!
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DetailPokeCell
        cell.imageView.sd_setImage(with: pokedexContoller?.list[indexPath.item].imageUrl())
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        PokeService.shared.fetchPokemon(with: (pokedexContoller?.list[indexPath.item].getId()!)!) { poke in
            self.pokemonController?.pokemon = poke
            
        }
        
    }
}

extension PokemonCollectionViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 75
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: view.frame.width/3, bottom: 8, right: view.frame.width/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.height - 16)
        return CGSize(width: height, height: height)
    }
    
}

