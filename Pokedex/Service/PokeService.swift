//
//  PokeService.swift
//  Pokedex
//
//  Created by Yunus Emre Kaya on 6.08.2022.
//

import PokemonAPI
import Alamofire
class PokeService{
    
    static let shared = PokeService()
    
    func fetchPokemon(with id: Int, completion: @escaping (Pokemon) -> Void){
        let request = AF.request("https://pokeapi.glitch.me/v1/pokemon/\(id)")
        request.responseDecodable(of: Pokemon.self) { response in
            guard let poke = response.value else {return}
            completion(poke)
        }
    }
    func fetchPokemon(with name: String, completion: @escaping (Pokemon) -> Void){
        let request = AF.request("https://pokeapi.glitch.me/v1/pokemon/\(name)")
        request.responseDecodable(of: Pokemon.self) { response in
            guard let poke = response.value else {return}
            completion(poke)
        }
    }
    
    func fetchAllPokemon(completion: @escaping ([AllPokemon]) -> Void){
        let request = AF.request("https://pokeapi.co/api/v2/pokemon/?limit=807")
        request.responseDecodable(of: Pokes.self) { response in
            guard let pokes = response.value else {return}
            completion(pokes.results!)
        }
    }
    
    func fetchTypePokemon(with type: String, completion: @escaping ([AllPokemon]) -> Void){
        let request = AF.request("https://pokeapi.co/api/v2/type/\(type.lowercased())/")
        request.responseDecodable(of: PokemonWithType.self) { response in
            
            guard let pokes = response.value else {return}
            var allPoke = [AllPokemon]()
            for i in 0..<pokes.pokemon!.count{
                allPoke.append(pokes.pokemon![i].pokemon!)
            }
            completion(allPoke)
        }
        
    }
    
}
