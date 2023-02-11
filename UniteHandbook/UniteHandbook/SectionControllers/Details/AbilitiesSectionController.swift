//
//  AbilitiesSectionController.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/10/23.
//

import IGListKit

protocol AbilitiesSectionControllerDelegate {
    func didSelectInfo()
}

class AbilitiesSectionController: ListSectionController {
    
    private var model: AbilityDetails? = nil
    private var delegate: AbilitiesSectionControllerDelegate?
    
    convenience init(delegate: AbilitiesSectionControllerDelegate) {
        self.init()
        self.delegate = delegate
    }
    
    internal override func numberOfItems() -> Int {
        return 1
    }
    internal override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: self.collectionContext?.containerSize.width ?? 0, height: 75)
    }
    internal override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = (self.collectionContext?.dequeueReusableCell(of: AbilityCollectionViewCell.self, for: self, at: index))! as? AbilityCollectionViewCell else { return UICollectionViewCell() }
        
        guard let model = model else { return cell }
        cell.image = UIImage(named: model.imageName.lowercased())
        cell.name = model.name
        cell.sectionController = self
        
        return cell
    }
    internal override func didUpdate(to object: Any) {
        self.model = object as? AbilityDetails
    }
    internal override func didSelectItem(at index: Int) {
        guard let model = model else { return }
    }
    internal func didSelectInfo() {
        self.delegate?.didSelectInfo()
    }
}

public class AbilityDetails : BaseListDiffable {
    public var imageName: String
    public var name: String
    public var desc: String
    
    public init(imageName: String, name: String, desc: String) {
        self.imageName = imageName
        self.name = name
        self.desc = desc
    }
}
