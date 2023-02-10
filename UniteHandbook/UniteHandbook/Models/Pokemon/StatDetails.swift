//
//  StatDetails.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/9/23.
//

import Foundation

public class StatDetails : Decodable {
    
    enum CodingKeys: String, CodingKey {
        case level = "Level"
        case hp = "HP"
        case attack = "Attack"
        case defense = "Defense"
        case spAttack = "SpAttack"
        case spDefense = "SpDefense"
        case critRate = "CritRate"
        case cdr = "CDR"
        case lifesteal = "Lifesteal"
        case atkSpd = "AtkSpd"
        case speed = "Speed"
    }
    
    public var level: Int = 0
    public var hp: Int = 0
    public var attack: Int = 0
    public var defense: Int = 0
    public var spAttack: Int = 0
    public var spDefense: Int = 0
    public var critRate: Float = 0
    public var cdr: Float = 0
    public var lifesteal: Float = 0
    public var atkSpd: Float = 0
    public var speed: Int = 0
    
    public init() { }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.level = try container.decode(Int.self, forKey: .level)
        self.hp = try container.decode(Int.self, forKey: .hp)
        self.attack = try container.decode(Int.self, forKey: .attack)
        self.defense = try container.decode(Int.self, forKey: .defense)
        self.spAttack = try container.decode(Int.self, forKey: .spAttack)
        self.spDefense = try container.decode(Int.self, forKey: .spDefense)
        self.critRate = try container.decode(Float.self, forKey: .critRate)
        self.cdr = try container.decode(Float.self, forKey: .cdr)
        self.lifesteal = try container.decode(Float.self, forKey: .lifesteal)
        self.atkSpd = try container.decode(Float.self, forKey: .atkSpd)
        self.speed = try container.decode(Int.self, forKey: .speed)
    }
}
