//
//  Ability.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/9/23.
//

import Foundation

public class Ability : Decodable {
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case desc = "Desc"
    }
    
    public var name: String = ""
    public var desc: String = ""
    
    public init() { }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.desc = try container.decode(String.self, forKey: .desc)
    }
}
