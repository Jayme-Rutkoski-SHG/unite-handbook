//
//  StatSliderCollectionViewCell.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/13/23.
//

import UIKit
import SnapKit

class StatSliderCollectionViewCell: UICollectionViewCell {
    
    public var currentLevel: Int = 1 {
        didSet {
            self.sliderStats.value = Float(self.currentLevel)
            self.labelValue.text = "\(self.currentLevel)"
        }
    }
    public var sectionController: StatSliderSectionController?
    
    private var viewContainer: UIView = {
        let view = UIView(frame: .zero)
        
        return view
    }()
    private var sliderStats: UISlider = {
        let slider = UISlider(frame: .zero)
        slider.minimumValue = 1
        slider.maximumValue = 15
        
        return slider
    }()
    private var labelTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.font = UIFont(name: "Georgia-Bold", size: 16.0)
        label.textColor = .black
        label.text = "Current Level"
        
        return label
    }()
    private var labelValue: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.font = UIFont(name: "Georgia-Bold", size: 16.0)
        label.textColor = .black
        
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
            make.left.equalTo(self.contentView.snp.left).offset(15)
            make.right.equalTo(self.contentView.snp.right).offset(-15)
            make.bottom.equalTo(self.contentView.snp.bottom)
        }
        self.viewContainer.addSubview(self.labelTitle)
        self.labelTitle.snp.makeConstraints { make in
            make.top.equalTo(self.viewContainer.snp.top)
            make.left.equalTo(self.viewContainer.snp.left)
        }
        self.viewContainer.addSubview(self.labelValue)
        self.labelValue.snp.makeConstraints { make in
            make.top.equalTo(self.viewContainer.snp.top)
            make.right.equalTo(self.viewContainer.snp.right)
        }
        self.viewContainer.addSubview(self.sliderStats)
        self.sliderStats.snp.makeConstraints { make in
            make.top.equalTo(self.labelTitle.snp.bottom).offset(5)
            make.left.equalTo(self.viewContainer.snp.left)
            make.right.equalTo(self.viewContainer.snp.right)
        }
        
    }
}
