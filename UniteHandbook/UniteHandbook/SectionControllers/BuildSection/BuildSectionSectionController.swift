//
//  BuildSectionSectionController.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/16/23.
//

import IGListKit

protocol BuildSectionSectionControllerDelegate: AnyObject {
    func didClickDelete(section: BuildSection)
}

class BuildSectionSectionController: ListSectionController {
    
    private var model: BuildSection? = nil
    private weak var delegate: BuildSectionSectionControllerDelegate?
    
    convenience init(delegate: BuildSectionSectionControllerDelegate) {
        self.init()
        self.delegate = delegate
    }
    
    internal override func numberOfItems() -> Int {
        return 1
    }
    internal override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: self.collectionContext?.containerSize.width ?? 0, height: 350)
    }
    internal override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = (self.collectionContext?.dequeueReusableCell(of: BuildSectionCollectionViewCell.self, for: self, at: index))! as? BuildSectionCollectionViewCell else { return UICollectionViewCell() }
        
        guard let model = model else { return cell }
        cell.name = model.name
        cell.imagesMoves = model.imagesMoves
        cell.imagesHeldItems = model.imagesHeldItems
        cell.imageBattleItem = model.imageBattleItem
        cell.imageAltHeldItem = model.imageAltHeldItem
        cell.imageAltBattleItem = model.imageAltBattleItem
        cell.isCustomBuild = model.isCustomBuild
        cell.sectionController = self
        
        return cell
    }
    internal override func didUpdate(to object: Any) {
        self.model = object as? BuildSection
    }
    internal override func didSelectItem(at index: Int) {

    }
    internal func didClickDelete() {
        guard let model = self.model else { return }
        self.delegate?.didClickDelete(section: model)
    }
}

public class BuildSection : BaseListDiffable {
    public var name: String
    public var imagesMoves: [UIImage?]
    public var imagesHeldItems: [UIImage?]
    public var imageBattleItem: UIImage?
    public var imageAltHeldItem: UIImage?
    public var imageAltBattleItem: UIImage?
    public var isCustomBuild: Bool = false

    public init(name: String, imagesMoves: [UIImage?], imagesHeldItems: [UIImage?], imageBattleItem: UIImage?, imageAltHeldItem: UIImage?, imageAltBattleItem: UIImage?, isCustomBuild: Bool) {
        self.name = name
        self.imagesMoves = imagesMoves
        self.imagesHeldItems = imagesHeldItems
        self.imageBattleItem = imageBattleItem
        self.imageAltHeldItem = imageAltHeldItem
        self.imageAltBattleItem = imageAltBattleItem
        self.isCustomBuild = isCustomBuild
    }
}


