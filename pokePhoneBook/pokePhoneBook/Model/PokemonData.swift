//
//  PokemonData.swift
//  pokePhoneBook
//
//  Created by jae hoon lee on 12/9/24.
//

struct PokemonData: Codable {
    let id : Int
    let name : String
    let height : Int
    let weight : Int
    let sprites: Sprites
}

struct Sprites: Codable {
    let frontDefault : String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
