//
//  Move.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/9/23.
//

import Foundation

public class Move : Codable {
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case category = "Category"
        case cooldown = "Cooldown"
        case levelDetails = "LevelDetails"
        case upgrades = "Upgrades"
    }
    
    public init() { }
    
    public var name: String = ""
    public var category: String = ""
    public var cooldown: Double = 0
    public var levelDetails: [LevelDetails] = [LevelDetails]()
    public var upgrades: [Move]?
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.category, forKey: .category)
        try container.encode(self.cooldown, forKey: .cooldown)
        try container.encode(self.levelDetails, forKey: .levelDetails)
        try container.encode(self.upgrades, forKey: .upgrades)
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.category = try container.decode(String.self, forKey: .category)
        self.cooldown = try container.decode(Double.self, forKey: .cooldown)
        self.levelDetails = try container.decode([LevelDetails].self, forKey: .levelDetails)
        self.upgrades = try container.decodeIfPresent([Move].self, forKey: .upgrades)
    }
}
