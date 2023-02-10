//
//  Pokemon.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/9/23.
//

import Foundation

public class Pokemon {
    
    public var name: String = ""
    public var attackStyle: String = ""
    public var role: String = ""
    public var style: String = ""
    public var difficulty: String = ""
    public var ability: Ability = Ability()
    public var moves: [Move] = [Move]()
    public var stats: [StatDetails] = [StatDetails]()
}
