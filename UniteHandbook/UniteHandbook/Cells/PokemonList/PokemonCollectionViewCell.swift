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
    public var role: String = "" {
        didSet {
            self.labelRole.text = self.role
        }
    }
    public var difficulty: String = "" {
        didSet {
            self.labelDifficulty.text = self.difficulty
        }
    }
    public var image: UIImage? {
        didSet {
            self.imageView.image = self.image
        }
    }
    
    private var labelName: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.font = UIFont(name: "Georgia-Bold", size: 16.0)
        
        return label
    }()
    private var labelRole: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.font = UIFont(name: "Georgia-Italic", size: 14.0)
        
        return label
    }()
    private var labelDifficulty: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.font = UIFont(name: "Georgia-Italic", size: 14.0)
        
        return label
    }()
    private var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    private var imageViewRight: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "right_arrow")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        return stackView
    }()
    private var viewSeparator: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .black
        
        return view
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    private func setup() {
        self.contentView.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { make in
            make.left.equalTo(self.contentView.snp.left).offset(15)
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.height.equalTo(70)
            make.width.equalTo(70)
        }
        self.contentView.addSubview(self.labelName)
        self.labelName.snp.makeConstraints { make in
            make.left.equalTo(self.imageView.snp.right).offset(8)
            make.top.equalTo(self.imageView.snp.top)
        }
        self.contentView.addSubview(self.stackView)
        self.stackView.snp.makeConstraints { make in
            make.left.equalTo(self.imageView.snp.right).offset(8)
            make.top.equalTo(self.labelName.snp.bottom).offset(6)
        }
        self.stackView.addArrangedSubview(self.labelRole)
        self.stackView.addArrangedSubview(self.labelDifficulty)
        
        self.contentView.addSubview(self.viewSeparator)
        self.viewSeparator.snp.makeConstraints { make in
            make.top.equalTo(self.imageView.snp.bottom).offset(4.7)
            make.left.equalTo(self.contentView.snp.left).offset(10)
            make.right.equalTo(self.contentView.snp.right).offset(10)
            make.height.equalTo(0.3)
        }
        
        self.contentView.addSubview(self.imageViewRight)
        self.imageViewRight.snp.makeConstraints { make in
            make.right.equalTo(self.contentView.snp.right).offset(-15)
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.height.equalTo(25)
            make.width.equalTo(25)
        }
    }
}
