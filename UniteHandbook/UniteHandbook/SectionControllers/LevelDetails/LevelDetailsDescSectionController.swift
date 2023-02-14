//
//  LevelDetailsDescSectionController.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/13/23.
//

import IGListKit

class LevelDetailsDescSectionController: ListSectionController {
    
    private var model: LevelDetailsDesc? = nil
    
    internal override func numberOfItems() -> Int {
        return 1
    }
    internal override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: self.collectionContext?.containerSize.width ?? 0, height: 40)
    }
    internal override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = (self.collectionContext?.dequeueReusableCell(of: LevelDetailsDescCollectionViewCell.self, for: self, at: index))! as? LevelDetailsDescCollectionViewCell else { return UICollectionViewCell() }
        
        guard let model = model else { return cell }
        cell.desc = model.desc
        
        return cell
    }
    internal override func didUpdate(to object: Any) {
        self.model = object as? LevelDetailsDesc
    }
    internal override func didSelectItem(at index: Int) {

    }
}

public class LevelDetailsDesc : BaseListDiffable {
    public var desc: String
    
    public init(desc: String) {
        self.desc = desc
    }
}


