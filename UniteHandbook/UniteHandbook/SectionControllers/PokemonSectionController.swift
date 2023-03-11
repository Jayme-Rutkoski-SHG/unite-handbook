//
//  PokemonSectionController.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/9/23.
//

import IGListKit

protocol PokemonSectionControllerDelegate: AnyObject {
    func didSelectPokemon(pokemon: Pokemon)
}

class PokemonSectionController: ListSectionController {
    
    private var model: Pokemon? = nil
    private weak var delegate: PokemonSectionControllerDelegate?
    
    convenience init(delegate: PokemonSectionControllerDelegate) {
        self.init()
        self.delegate = delegate
    }
    
    internal override func numberOfItems() -> Int {
        return 1
    }
    internal override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: self.collectionContext?.containerSize.width ?? 0, height: 79.5)
    }
    internal override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = (self.collectionContext?.dequeueReusableCell(of: PokemonCollectionViewCell.self, for: self, at: index))! as? PokemonCollectionViewCell else { return UICollectionViewCell() }
        
        guard let model = model else { return cell }
        cell.name = model.name
        cell.image = UIImage(named: model.name.lowercased())
        cell.role = model.role
        cell.difficulty = model.difficulty
        
        return cell
    }
    internal override func didUpdate(to object: Any) {
        self.model = object as? Pokemon
    }
    internal override func didSelectItem(at index: Int) {
        guard let model = model else { return }
        self.delegate?.didSelectPokemon(pokemon: model)
    }
}
