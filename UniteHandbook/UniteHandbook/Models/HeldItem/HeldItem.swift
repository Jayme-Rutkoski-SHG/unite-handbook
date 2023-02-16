//
//  HeldItem.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/15/23.
//

import Foundation

public class HeldItem : BaseListDiffable, Decodable {
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case bonusStats = "BonusStats"
        case levelBonus = "LevelBonus"
        case desc = "Desc"
    }
    
    public var name: String = ""
    public var bonusStats: [BonusStat] = [BonusStat]()
    public var levelBonus: BonusStat = BonusStat()
    public var desc: String = ""
    
    public override init() { }

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.bonusStats = try container.decode([BonusStat].self, forKey: .bonusStats)
        self.levelBonus = try container.decode(BonusStat.self, forKey: .levelBonus)
        self.desc = try container.decode(String.self, forKey: .desc)
    }
    
    static func loadJson(filename fileName: String) -> HeldItem {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(HeldItem.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return HeldItem()
    }
}
