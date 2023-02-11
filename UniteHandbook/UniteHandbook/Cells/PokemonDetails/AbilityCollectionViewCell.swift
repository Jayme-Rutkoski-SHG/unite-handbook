//
//  AbilityCollectionViewCell.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/10/23.
//

import UIKit
import SnapKit

class AbilityCollectionViewCell: UICollectionViewCell {
    
    public var name: String = "" {
        didSet {
            self.labelName.text = self.name
        }
    }
    public var image: UIImage? {
        didSet {
            self.imageView.image = self.image
        }
    }
    public var sectionController: AbilitiesSectionController?
    
    private var viewContainer: UIView = {
        let view = UIView(frame: .zero)
        
        return view
    }()
    private var labelName: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.font = UIFont(name: "Georgia-Bold", size: 16.0)
        
        return label
    }()
    private var labelDesc: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.font = UIFont(name: "Georgia", size: 14.0)
        label.numberOfLines = 0
        label.text = "Passive Ability"
        
        return label
    }()
    private var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    private var imageViewInfo: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "info.png")
        
        return imageView
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    private func setup() {
        self.contentView.addSubview(self.viewContainer)
        self.viewContainer.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.snp.top).offset(15)
            make.left.equalTo(self.contentView.snp.left).offset(15)
            make.right.equalTo(self.contentView.snp.right).offset(-15)
            make.bottom.equalTo(self.contentView.snp.bottom)
        }
        self.viewContainer.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { make in
            make.top.equalTo(self.viewContainer.snp.top)
            make.left.equalTo(self.viewContainer.snp.left)
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
        self.viewContainer.addSubview(self.labelName)
        self.labelName.snp.makeConstraints { make in
            make.left.equalTo(self.imageView.snp.right).offset(8)
            make.top.equalTo(self.imageView.snp.top)
        }
        self.viewContainer.addSubview(self.imageViewInfo)
        self.imageViewInfo.snp.makeConstraints { make in
            make.centerY.equalTo(self.labelName.snp.centerY)
            make.left.equalTo(self.labelName.snp.right).offset(8)
            make.height.equalTo(22)
            make.width.equalTo(22)
        }

        self.viewContainer.addSubview(self.labelDesc)
        self.labelDesc.snp.makeConstraints { make in
            make.top.equalTo(self.labelName.snp.bottom).offset(8)
            make.left.equalTo(self.imageView.snp.right).offset(8)
            make.right.equalTo(self.viewContainer.snp.right)
        }
    }
    
    @objc func imageViewInfo_TapGesture() {
        self.sectionController?.didSelectInfo()
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        // note: don't change the width
        var height = ceil(size.height)
        if self.labelDesc.bounds.size.height > size.height {
            height = self.labelDesc.bounds.size.height + self.labelName.bounds.size.height + 8 + 15
        }
        newFrame.size.height = height
        layoutAttributes.frame = newFrame
        return layoutAttributes
    }
}

