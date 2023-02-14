//
//  HeaderDividerCollectionViewCell.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/11/23.
//

import UIKit
import SnapKit

class HeaderDividerCollectionViewCell: UICollectionViewCell {
    
    public var title: String = "" {
        didSet {
            self.labelTitle.text = self.title
        }
    }
    public var isSubHeader: Bool = false {
        didSet {
            if (isSubHeader) {
                self.viewContainer.backgroundColor = UIColor(hex: 0x3B276B)
                self.labelTitle.textColor = .white
                
                self.viewContainer.snp.remakeConstraints { make in
                    make.top.equalTo(self.contentView.snp.top)
                    make.left.equalTo(self.contentView.snp.left)
                    make.right.equalTo(self.contentView.snp.right)
                    make.bottom.equalTo(self.contentView.snp.bottom)
                }
                
                self.labelTitle.snp.remakeConstraints { make in
                    make.left.equalTo(self.viewContainer.snp.left).offset(22)
                    make.centerY.equalTo(self.viewContainer.snp.centerY)
                }
                super.updateConstraints()
                self.viewContainer.layer.mask = self.gradient
            }
        }
    }
    
    private var viewContainer: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(hex: 0xF9CB53)
        
        return view
    }()
    private var labelTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.font = UIFont(name: "Georgia-Bold", size: 14.0)
        label.textColor = .black
        
        return label
    }()
    
    private lazy var gradient: CAGradientLayer = {
        var textWidthRatio = (self.labelTitle.text!.widthWithConstrainedHeight(25, font: self.labelTitle.font)) / self.contentView.frame.width
        let mask = CAGradientLayer()
        print(textWidthRatio)
        mask.startPoint = CGPointMake(1.0, 0.5)
        mask.endPoint = CGPointMake(textWidthRatio, 0.5)
        let whiteColor = UIColor.white
        mask.colors = [whiteColor.withAlphaComponent(0.0).cgColor, whiteColor.withAlphaComponent(1.0), whiteColor.withAlphaComponent(1.0).cgColor]
        mask.locations = [NSNumber(value: 0.0),NSNumber(value: 1-textWidthRatio), NSNumber(value: 1.0)]
        mask.frame = self.contentView.bounds
        
        return mask
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
            make.height.equalTo(35)
            make.width.equalTo(self.contentView.snp.width)
        }
        self.viewContainer.addSubview(self.labelTitle)
        self.labelTitle.snp.makeConstraints { make in
            make.center.equalTo(self.viewContainer.snp.center)
        }
    }
}
