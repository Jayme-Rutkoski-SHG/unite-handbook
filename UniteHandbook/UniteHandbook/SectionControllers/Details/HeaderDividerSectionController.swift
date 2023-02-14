//
//  HeaderDividerSectionController.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/11/23.
//

import IGListKit

class HeaderDividerSectionController: ListSectionController {
    
    private var model: HeaderDivider? = nil
    
    internal override func numberOfItems() -> Int {
        return 1
    }
    internal override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: self.collectionContext?.containerSize.width ?? 0, height: 35)
    }
    internal override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = (self.collectionContext?.dequeueReusableCell(of: HeaderDividerCollectionViewCell.self, for: self, at: index))! as? HeaderDividerCollectionViewCell else { return UICollectionViewCell() }
        
        guard let model = model else { return cell }
        cell.title = model.title
        cell.isSubHeader = model.isSubHeader
        
        return cell
    }
    internal override func didUpdate(to object: Any) {
        self.model = object as? HeaderDivider
    }
    internal override func didSelectItem(at index: Int) {

    }
}

public class HeaderDivider : BaseListDiffable {
    public var title: String
    public var isSubHeader: Bool
    
    public init(title: String) {
        self.title = title
        self.isSubHeader = false
    }
    public init(title: String, isSubHeader: Bool) {
        self.title = title
        self.isSubHeader = isSubHeader
    }
}

