//
//  HeldItemLoader.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/18/23.
//

import Foundation

public class HeldItemLoader {

    public static func loadHeldItems() -> [HeldItem] {
        var heldItemList = [HeldItem]()
        for name in PokemonJsonHelper.getAllHeldItemNames() {
            let heldItem = HeldItem.loadJson(filename: "\(name)")
            if (heldItem.name.count > 0) {
                heldItemList.append(heldItem)
            }
        }
        return heldItemList
    }
}
