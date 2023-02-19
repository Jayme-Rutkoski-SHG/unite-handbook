//
//  Ability.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/9/23.
//

import Foundation

public class Ability : Codable {
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case desc = "Desc"
    }
    
    public var name: String = ""
    public var desc: String = ""
    
    public init() { }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.desc, forKey: .desc)
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.desc = try container.decode(String.self, forKey: .desc)
    }
}
