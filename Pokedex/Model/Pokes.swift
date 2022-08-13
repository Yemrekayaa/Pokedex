//
//  TestModel.swift
//  Pokedex
//
//  Created by Yunus Emre Kaya on 11.08.2022.
//

import Foundation

// MARK: - Pokes
struct Pokes: Codable {
    let count: Int?
    let results: [AllPokemon]?
}

// MARK: - AllPokemon
struct AllPokemon: Codable {
    let name: String?
    let url: String?
    let id: Int?
    var getId: () -> Int? {
        return{
            Int((url?.components(separatedBy: "/")[6])!)
        }
    }
    var imageUrl: () -> URL {
        return{
            URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(url!.components(separatedBy: "/")[6]).png")!
        }
    }
    var type: [String]?
    
}


// MARK: - PokemonElement
struct PokemonTestElement: Codable {
    let number, name, species: String?
    let types: [String]?
    let abilities: Abilities?
    let eggGroups: [String]?
    let gender: [Double]?
    let height, weight: String?
    let family: Family?
    let starter, legendary, mythical, ultraBeast: Bool?
    let mega: Bool?
    let gen: Int?
    let sprite: String?
    let description: String?

    enum CodingKeys: String, CodingKey {
        case number, name, species, types, abilities, eggGroups, gender, height, weight, family, starter, legendary, mythical, ultraBeast, mega, gen, sprite
        case description
    }
}

// MARK: - Abilities
struct Abilities: Codable {
    let normal, hidden: [String]?
}

// MARK: - Family
struct Family: Codable {
    let id, evolutionStage: Int?
    let evolutionLine: [String]?
}

typealias Pokemon = [PokemonTestElement]

// MARK: - PokemonWithType
struct PokemonWithType: Codable {
    let pokemon: [PokemonElement]?
}

// MARK: - PokemonElement
struct PokemonElement: Codable {
    let pokemon: AllPokemon?
    let slot: Int?
}

// MARK: - PokemonPokemon
struct PokemonPokemon: Codable {
    let name: String?
    let url: String?
}

