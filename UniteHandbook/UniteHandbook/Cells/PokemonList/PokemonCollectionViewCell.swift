//
//  PokemonCollectionViewCell.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/9/23.
//

import UIKit
import SnapKit

class PokemonCollectionViewCell: UICollectionViewCell {
    
    public var name: String = "" {
        didSet {
            self.labelName.text = self.name
        }
    }
    
    private var labelName: UILabel {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.font = UIFont(name: "Arial", size: 14.0)
        
        return label
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    private func setup() {
        self.contentView.addSubview(self.labelName)
        self.labelName.snp.makeConstraints { make in
            make.left.equalTo(self.contentView.snp.left).offset(15)
            make.centerY.equalTo(self.contentView.snp.centerY)
        }
    }
}
