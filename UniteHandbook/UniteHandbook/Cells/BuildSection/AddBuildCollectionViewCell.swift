//
//  AddBuildCollectionViewCell.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/16/23.
//

import UIKit
import SnapKit

class AddBuildCollectionViewCell: UICollectionViewCell {
    
    private var viewContainer: UIView = {
        let view = UIView(frame: .zero)
        
        return view
    }()
    private lazy var buttonAdd: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Add Build", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Georgia-Bold", size: 14.0)
        button.addTarget(self, action: #selector(buttonAdd_TouchUpInside), for: .touchUpInside)
        button.backgroundColor = UIColor(hex: 0xF9CB53)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10.0
        
        return button
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
        self.viewContainer.addSubview(self.buttonAdd)
        self.buttonAdd.snp.makeConstraints { make in
            make.left.equalTo(self.viewContainer.snp.left)
            make.right.equalTo(self.viewContainer.snp.right)
            make.height.equalTo(60)
        }
    }
    
    @objc private func buttonAdd_TouchUpInside(sender: UIButton) {

    }
}


