//
//  Move.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/9/23.
//

import Foundation

public class Move : Decodable {
    
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
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.category = try container.decode(String.self, forKey: .category)
        self.cooldown = try container.decode(Double.self, forKey: .cooldown)
        self.levelDetails = try container.decode([LevelDetails].self, forKey: .levelDetails)
        self.upgrades = try container.decodeIfPresent([Move].self, forKey: .upgrades)
    }
}
