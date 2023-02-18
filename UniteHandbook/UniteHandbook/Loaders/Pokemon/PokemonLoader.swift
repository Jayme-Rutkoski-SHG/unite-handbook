//
//  PokemonLoader.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/9/23.
//

import Foundation

public class PokemonLoader {

    public static func loadPokemon() -> [Pokemon] {
        var pokemonList = [Pokemon]()
        for name in PokemonJsonHelper.getAllPokemonNames() {
            let pokemon = Pokemon.loadJson(filename: "\(name)")
            if (pokemon.name.count > 0) {
                pokemonList.append(pokemon)
            }
        }
        return pokemonList
    }
}
