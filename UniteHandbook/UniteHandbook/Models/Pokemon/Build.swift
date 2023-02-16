//
//  Build.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/15/23.
//

import Foundation

public class Build : Decodable {
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case moveOrders = "MoveOrders"
        case heldItems = "HeldItems"
        case altHeldItem = "AltHeldItem"
        case battleItem = "BattleItem"
        case altBattleItem = "AltBattleItem"
    }
    
    public var name: String = ""
    public var moveOrders: [String] = [String]()
    public var heldItems: [String] = [String]()
    public var altHeldItem: String = ""
    public var battleItem: String = ""
    public var altBattleItem: String = ""
    
    public init() { }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.moveOrders = try container.decode([String].self, forKey: .moveOrders)
        self.heldItems = try container.decode([String].self, forKey: .heldItems)
        self.altHeldItem = try container.decode(String.self, forKey: .altHeldItem)
        self.battleItem = try container.decode(String.self, forKey: .battleItem)
        self.altBattleItem = try container.decode(String.self, forKey: .altBattleItem)
    }
}
