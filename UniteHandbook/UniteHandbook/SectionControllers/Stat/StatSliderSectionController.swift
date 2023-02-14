//
//  StatSliderSectionController.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/13/23.
//

import IGListKit

protocol StatSliderSectionControllerDelegate {
    func didChangeLevel(level: Int)
}

class StatSliderSectionController: ListSectionController {
    
    private var model: StatSlider? = nil
    private var delegate: StatSliderSectionControllerDelegate?
    
    convenience init(delegate: StatSliderSectionControllerDelegate) {
        self.init()
        self.delegate = delegate
    }
    
    internal override func numberOfItems() -> Int {
        return 1
    }
    internal override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: self.collectionContext?.containerSize.width ?? 0, height: 65)
    }
    internal override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = (self.collectionContext?.dequeueReusableCell(of: StatSliderCollectionViewCell.self, for: self, at: index))! as? StatSliderCollectionViewCell else { return UICollectionViewCell() }
        
        guard let model = model else { return cell }
        cell.currentLevel = model.currentLevel
        cell.sectionController = self
        
        return cell
    }
    internal override func didUpdate(to object: Any) {
        self.model = object as? StatSlider
    }
    internal override func didSelectItem(at index: Int) {

    }
    
    internal func didChangeLevel(level: Int) {
        self.delegate?.didChangeLevel(level: level)
    }
}

public class StatSlider : BaseListDiffable {
    public var currentLevel: Int
    
    public init(currentLevel: Int) {
        self.currentLevel = currentLevel
    }
}

