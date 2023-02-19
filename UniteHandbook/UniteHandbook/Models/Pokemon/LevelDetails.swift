//
//  LevelDetails.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/9/23.
//

import Foundation

public class LevelDetails : Codable {
    
    enum CodingKeys: String, CodingKey {
        case level = "Level"
        case desc = "Desc"
    }
    
    public var level: Int = 0
    public var desc: String = ""
    
    public init() { }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.level, forKey: .level)
        try container.encode(self.desc, forKey: .desc)
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.level = try container.decode(Int.self, forKey: .level)
        self.desc = try container.decode(String.self, forKey: .desc)
    }
}
