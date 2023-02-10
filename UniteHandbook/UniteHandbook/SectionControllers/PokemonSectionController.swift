//
//  PokemonSectionController.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/9/23.
//

import IGListKit

class PokemonSectionController: ListSectionController {
    
    private var model: Pokemon? = nil
    
    internal override func numberOfItems() -> Int {
        return 1
    }
    internal override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: self.collectionContext?.containerSize.width ?? 0, height: 55)
    }
    internal override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = (self.collectionContext?.dequeueReusableCell(of: PokemonCollectionViewCell.self, for: self, at: index))! as? PokemonCollectionViewCell else { return UICollectionViewCell() }
        
        guard let model = model else { return cell }
        cell.name = model.name
        
        return cell
    }
    internal override func didUpdate(to object: Any) {
        self.model = object as? Pokemon
    }
    internal override func didSelectItem(at index: Int) {
        
    }
}
