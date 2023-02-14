//
//  LevelDetailsDescCollectionViewCell.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/13/23.
//

import UIKit
import SnapKit

class LevelDetailsDescCollectionViewCell: UICollectionViewCell {
    
    public var desc: String = "" {
        didSet {
            self.labelDesc.text = self.desc
        }
    }
    
    private var viewContainer: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        
        return view
    }()
    private var labelDesc: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.font = UIFont(name: "Georgia", size: 14.0)
        label.textColor = .black
        label.numberOfLines = 0
        
        return label
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
            make.top.equalTo(self.contentView.snp.top)
            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(self.contentView.snp.right)
            make.bottom.equalTo(self.contentView.snp.bottom)
        }
        self.viewContainer.addSubview(self.labelDesc)
        self.labelDesc.snp.makeConstraints { make in
            make.center.equalTo(self.viewContainer.snp.center)
            make.left.equalTo(self.viewContainer.snp.left)
            make.right.equalTo(self.viewContainer.snp.right)
        }
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        super.preferredLayoutAttributesFitting(layoutAttributes)
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        // note: don't change the width
        var height = ceil(size.height)
        if self.labelDesc.bounds.size.height > size.height {
            height = self.labelDesc.bounds.size.height
        }
        newFrame.size.height = height
        layoutAttributes.frame = newFrame
        return layoutAttributes
    }
}


