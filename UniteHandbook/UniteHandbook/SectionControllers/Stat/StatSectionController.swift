//
//  StatSectionController.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/13/23.
//

import IGListKit

class StatSectionController: ListSectionController {
    
    private var model: StatSection? = nil
    
    internal override func numberOfItems() -> Int {
        return 1
    }
    internal override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: self.collectionContext?.containerSize.width ?? 0, height: 40)
    }
    internal override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = (self.collectionContext?.dequeueReusableCell(of: StatCollectionViewCell.self, for: self, at: index))! as? StatCollectionViewCell else { return UICollectionViewCell() }
        
        guard let model = model else { return cell }
        cell.title = model.title
        cell.value = model.value
        
        return cell
    }
    internal override func didUpdate(to object: Any) {
        self.model = object as? StatSection
    }
    internal override func didSelectItem(at index: Int) {

    }
}

public class StatSection : BaseListDiffable {
    public var title: String
    public var value: String
    
    public init(title: String, value: String) {
        self.title = title
        self.value = value
    }
}
