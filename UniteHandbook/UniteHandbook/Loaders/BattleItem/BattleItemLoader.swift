//
//  BattleItemLoader.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/18/23.
//

import Foundation

public class BattleItemLoader {

    public static func loadBattleItems() -> [BattleItem] {
        var battleItemList = [BattleItem]()
        for name in PokemonJsonHelper.getAllBattleItemNames() {
            let battleItem = BattleItem.loadJson(filename: "\(name)")
            if (battleItem.name.count > 0) {
                battleItemList.append(battleItem)
            }
        }
        return battleItemList
    }
}
