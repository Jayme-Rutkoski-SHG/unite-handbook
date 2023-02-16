//
//  BonusStat.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/15/23.
//

import Foundation

public class BonusStat : Decodable {
    
    enum CodingKeys: String, CodingKey {
        case label = "Label"
        case baseValue = "BaseValue"
        case incrementValue = "IncrementValue"
        case isPercent = "IsPercent"
    }
    
    public var label: String = ""
    public var baseValue: Float = 0
    public var incrementValue: Float = 1
    public var isPercent: Bool = false
    
    public init() { }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.label = try container.decode(String.self, forKey: .label)
        self.baseValue = try container.decode(Float.self, forKey: .baseValue)
        self.incrementValue = try container.decode(Float.self, forKey: .incrementValue)
        self.isPercent = try container.decode(Bool.self, forKey: .isPercent)
    }
}
