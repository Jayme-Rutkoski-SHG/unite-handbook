//
//  Move.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/9/23.
//

import Foundation

public class Move {
    
    public var name: String = ""
    public var category: String = ""
    public var cooldown: Double = 0
    public var levelDetails: [LevelDetails] = [LevelDetails]()
    public var upgrades: [Move] = [Move]()
}
