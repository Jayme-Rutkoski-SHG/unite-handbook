//
//  LevelDetailsLevelSectionController.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/13/23.
//

import IGListKit

class LevelDetailsLevelSectionController: ListSectionController {
    
    private var model: LevelDetailsLevel? = nil
    
    internal override func numberOfItems() -> Int {
        return 1
    }
    internal override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: self.collectionContext?.containerSize.width ?? 0, height: 30)
    }
    internal override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = (self.collectionContext?.dequeueReusableCell(of: LevelDetailsLevelCollectionViewCell.self, for: self, at: index))! as? LevelDetailsLevelCollectionViewCell else { return UICollectionViewCell() }
        
        guard let model = model else { return cell }
        cell.title = model.title
        
        return cell
    }
    internal override func didUpdate(to object: Any) {
        self.model = object as? LevelDetailsLevel
    }
    internal override func didSelectItem(at index: Int) {

    }
}

public class LevelDetailsLevel : BaseListDiffable {
    public var title: String
    
    public init(title: String) {
        self.title = title
    }
}



