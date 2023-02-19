//
//  Build.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/15/23.
//

import Foundation

public class Build : Codable {
    
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
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.moveOrders, forKey: .moveOrders)
        try container.encode(self.heldItems, forKey: .heldItems)
        try container.encode(self.altHeldItem, forKey: .altHeldItem)
        try container.encode(self.battleItem, forKey: .battleItem)
        try container.encode(self.altBattleItem, forKey: .altBattleItem)
    }
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.moveOrders = try container.decode([String].self, forKey: .moveOrders)
        self.heldItems = try container.decode([String].self, forKey: .heldItems)
        self.altHeldItem = try container.decode(String.self, forKey: .altHeldItem)
        self.battleItem = try container.decode(String.self, forKey: .battleItem)
        self.altBattleItem = try container.decode(String.self, forKey: .altBattleItem)
        self.isCustomBuild = try container.decodeIfPresent(Bool.self, forKey: .isCustomBuild)
    }
}
