//
//  BattleItem.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/15/23.
//

import Foundation

public class BattleItem : BaseListDiffable, Codable {
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case cooldown = "Cooldown"
        case desc = "Desc"
    }
    
    public var name: String = ""
    public var cooldown: Double = 0
    public var desc: String = ""
    
    public override init() { }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.cooldown, forKey: .cooldown)
        try container.encode(self.desc, forKey: .desc)
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.cooldown = try container.decode(Double.self, forKey: .cooldown)
        self.desc = try container.decode(String.self, forKey: .desc)
    }
    
    static func loadJson(filename fileName: String) -> BattleItem {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(BattleItem.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return BattleItem()
    }
}
