//
//  BuildSectionSectionController.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/16/23.
//

import IGListKit

class BuildSectionSectionController: ListSectionController {
    
    private var model: BuildSection? = nil
    
    internal override func numberOfItems() -> Int {
        return 1
    }
    internal override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: self.collectionContext?.containerSize.width ?? 0, height: 100)
    }
    internal override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = (self.collectionContext?.dequeueReusableCell(of: BuildSectionCollectionViewCell.self, for: self, at: index))! as? BuildSectionCollectionViewCell else { return UICollectionViewCell() }
        
        guard let model = model else { return cell }
        cell.name = model.name
        cell.images = model.images
        
        return cell
    }
    internal override func didUpdate(to object: Any) {
        self.model = object as? BuildSection
    }
    internal override func didSelectItem(at index: Int) {

    }
}

public class BuildSection : BaseListDiffable {
    public var name: String
    public var images: [UIImage?]

    public init(name: String, images: [UIImage?]) {
        self.name = name
        self.images = images
    }
}


