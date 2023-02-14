//
//  StatCollectionViewCell.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/13/23.
//

import UIKit
import SnapKit

class StatCollectionViewCell: UICollectionViewCell {
    
    public var title: String = "" {
        didSet {
            self.labelTitle.text = self.title
        }
    }
    public var value: String = "" {
        didSet {
            self.labelValue.text = self.value
        }
    }
    
    private var viewContainer: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        
        return view
    }()
    private var labelTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.font = UIFont(name: "Georgia-Bold", size: 16.0)
        label.textColor = .black
        
        return label
    }()
    private var labelValue: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.font = UIFont(name: "Georgia", size: 16.0)
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
            make.left.equalTo(self.contentView.snp.left)
            make.bottom.equalTo(self.contentView.snp.bottom)
        }
        self.viewContainer.addSubview(self.labelTitle)
        self.labelTitle.snp.makeConstraints { make in
            make.left.equalTo(self.viewContainer.snp.left)
            make.centerY.equalTo(self.viewContainer.snp.centerY)
        }
        self.viewContainer.addSubview(self.labelValue)
        self.labelValue.snp.makeConstraints { make in
            make.right.equalTo(self.viewContainer.snp.right)
            make.centerY.equalTo(self.viewContainer.snp.centerY)
        }
    }
}


