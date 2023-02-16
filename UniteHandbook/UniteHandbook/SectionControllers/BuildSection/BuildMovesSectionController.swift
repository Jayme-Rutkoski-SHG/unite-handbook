//
//  BuildMovesSectionController.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/16/23.
//

import IGListKit

class BuildMovesSectionController: ListSectionController {
    
    private var model: BuildMoves? = nil
    
    internal override func numberOfItems() -> Int {
        return 1
    }
    internal override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: self.collectionContext?.containerSize.width ?? 0, height: 100)
    }
    internal override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = (self.collectionContext?.dequeueReusableCell(of: BuildMovesCollectionViewCell.self, for: self, at: index))! as? BuildMovesCollectionViewCell else { return UICollectionViewCell() }
        
        guard let model = model else { return cell }
        cell.name = model.name
        cell.imagesMoves = model.imageMoves
        
        return cell
    }
    internal override func didUpdate(to object: Any) {
        self.model = object as? BuildMoves
    }
    internal override func didSelectItem(at index: Int) {

    }
}

public class BuildMoves : BaseListDiffable {
    public var name: String
    public var imageMoves: [UIImage?]

    public init(name: String, imageMoves: [UIImage?]) {
        self.name = name
        self.imageMoves = imageMoves
    }
}

