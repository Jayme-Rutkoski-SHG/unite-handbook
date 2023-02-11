//
//  MoveCollectionViewCell.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/10/23.
//

import UIKit
import SnapKit

class MoveCollectionViewCell: UICollectionViewCell {
    
    private var didRotate: Bool = false
    public var image: UIImage? {
        didSet {
            self.imageView.image = self.image
        }
    }
    
    public var name: String = "" {
        didSet {
            self.labelName.text = self.name
        }
    }
    public var category: String = "" {
        didSet {
            self.labelCategory.setTitle(self.category, for: .normal)
            self.labelCategory.setImage(UIImage(named: "\(self.category.lowercased()).png"), for: .normal)
            self.labelCategory.imageView?.snp.makeConstraints { make in
                make.height.equalTo(20)
                make.width.equalTo(20)
                make.right.equalTo(self.labelCategory.titleLabel!.snp.left).offset(-5)
            }
        }
    }
    public var cooldown: Double = 0 {
        didSet {
            self.labelCooldown.setTitle("\(cooldown)s", for: .normal)
            self.labelCooldown.setImage(UIImage(named: "cooldown.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
            self.labelCooldown.tintColor = UIColor(hex: 0xFFD283)
            self.labelCooldown.imageView?.snp.makeConstraints { make in
                make.height.equalTo(15)
                make.width.equalTo(15)
                make.right.equalTo(self.labelCooldown.titleLabel!.snp.left).offset(-8)
            }
        }
    }
    public var sectionController: MoveSectionController?
    
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
    private var labelCategory: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Georgia", size: 14.0)
        button.layer.cornerRadius = 8
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex:0x3B275E)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 0.5
        button.imageView?.contentMode = .scaleAspectFit
        
        return button
    }()
    private var labelCooldown: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Georgia", size: 14.0)
        button.layer.cornerRadius = 8
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex:0x3B275E)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 0.5
        button.imageView?.contentMode = .scaleAspectFit
        
        return button
    }()

    private var imageViewInfo: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "info.png")
        
        return imageView
    }()
    private var imageViewUpgrades: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "show_details.png")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .black
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()

    private var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .leading
        
        return stackView
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
            make.top.equalTo(self.imageView.snp.top)
            make.left.equalTo(self.imageView.snp.right).offset(8)
        }
        self.viewContainer.addSubview(self.imageViewInfo)
        self.imageViewInfo.snp.makeConstraints { make in
            make.centerY.equalTo(self.labelName.snp.centerY)
            make.left.equalTo(self.labelName.snp.right).offset(8)
            make.height.equalTo(22)
            make.width.equalTo(22)
        }
        
        self.viewContainer.addSubview(self.imageViewUpgrades)
        self.imageViewUpgrades.snp.makeConstraints { make in
            make.right.equalTo(self.viewContainer.snp.right)
            make.centerY.equalTo(self.imageView.snp.centerY)
            make.height.equalTo(25)
            make.width.equalTo(25)
        }

        self.viewContainer.addSubview(self.stackView)
        self.stackView.snp.makeConstraints { make in
            make.top.equalTo(self.labelName.snp.bottom).offset(8)
            make.left.equalTo(self.imageView.snp.right).offset(8)
            make.height.equalTo(30)
        }
        
        self.stackView.addArrangedSubview(self.labelCooldown)
        self.stackView.addArrangedSubview(self.labelCategory)
        
        self.imageViewInfo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageViewInfo_TapGesture(_:))))
        self.imageViewUpgrades.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageViewUpgrades_TapGesture(_:))))
    }
    
    @objc func imageViewInfo_TapGesture(_ sender: UITapGestureRecognizer) {
        self.sectionController?.didSelectInfo()
    }
    @objc func imageViewUpgrades_TapGesture(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5) {[weak self] in
            let angle = self?.didRotate == false ? CGFloat(Double.pi) : 0
            self?.imageViewUpgrades.transform = CGAffineTransform(rotationAngle: angle)
            self?.didRotate = !(self?.didRotate ?? true)
        }
        self.sectionController?.showUpgrades()
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        // note: don't change the width
        newFrame.size.height = ceil(size.height)
        layoutAttributes.frame = newFrame
        return layoutAttributes
    }
}

