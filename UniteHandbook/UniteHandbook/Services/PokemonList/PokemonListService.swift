//
//  PokemonListService.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/9/23.
//

import Foundation

public class PokemonListService {

    public static func loadPokemon() -> [Pokemon] {
        var pokemonList = [Pokemon]()
        for pokeName in PokemonHelper.getAllPokemonNames() {
            let pokemon = Pokemon.loadJson(filename: "\(pokeName)")
            if (pokemon.name.count > 0) {
                pokemonList.append(pokemon)
            }
        }
        return pokemonList
    }
}
