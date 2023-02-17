//
//  BuildSectionCollectionViewCell.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/16/23.
//

import UIKit
import SnapKit

class BuildSectionCollectionViewCell: UICollectionViewCell {
    
    public var name: String = "" {
        didSet {
            self.labelName.text = self.name
        }
    }
    public var imagesMoves: [UIImage?] = [UIImage?]() {
        didSet {
            if (self.stackViewMoves.subviews.count == 0) {
                for image in self.imagesMoves {
                    let imageView = UIImageView(image: image)
                    imageView.contentMode = .scaleAspectFit
                    imageView.snp.makeConstraints { make in
                        make.height.equalTo(50)
                        make.width.equalTo(50)
                    }
                    
                    let imageViewNext = UIImageView(image: UIImage(named: "next_arrow.png")?.withRenderingMode(.alwaysTemplate))
                    imageViewNext.contentMode = .scaleAspectFit
                    imageViewNext.tintColor = .black
                    imageViewNext.snp.makeConstraints { make in
                        make.height.equalTo(20)
                        make.width.equalTo(20)
                    }
                    
                    self.stackViewMoves.addArrangedSubview(imageView)
                    if self.imagesMoves.firstIndex(of: image) ?? 0 < self.imagesMoves.count - 1 {
                        self.stackViewMoves.addArrangedSubview(imageViewNext)
                    }
                }
            }
        }
    }
    public var imagesHeldItems: [UIImage?] = [UIImage?]() {
        didSet {
            if (self.stackViewHeldItems.subviews.count == 0) {
                for image in self.imagesHeldItems {
                    let imageView = UIImageView(image: image)
                    imageView.contentMode = .scaleAspectFit
                    imageView.snp.makeConstraints { make in
                        make.height.equalTo(50)
                        make.width.equalTo(50)
                    }
                    
                    self.stackViewHeldItems.addArrangedSubview(imageView)
                }
            }
        }
    }
    public var imageBattleItem: UIImage? {
        didSet {
            self.imageViewBattleItem.image = self.imageBattleItem
        }
    }
    public var imageAltHeldItem: UIImage? {
        didSet {
            if (self.imageAltHeldItem == nil) {
                self.labelAltHeldItem.isHidden = true
            }
            self.imageViewAltHeldItem.image = self.imageAltHeldItem
        }
    }
    public var imageAltBattleItem: UIImage? {
        didSet {
            if (self.imageAltBattleItem == nil) {
                self.labelAltBattleItem.isHidden = true
            }
            self.imageViewAltBattleItem.image = self.imageAltBattleItem
        }
    }
    
    private var viewBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(hex: 0xF9CB53)
        view.layer.cornerRadius = 15.0
        //view.layer.borderColor = UIColor(hex: 0x44347B).cgColor
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2
        
        return view
    }()
    private var viewContainer: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        
        return view
    }()
    private var labelName: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.font = UIFont(name: "Georgia-Bold", size: 20.0)
        
        return label
    }()
    private var labelHeldItems: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.font = UIFont(name: "Georgia-Bold", size: 16.0)
        label.text = "Held Items"
        
        return label
    }()
    private var labelAltHeldItem: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.font = UIFont(name: "Georgia-Bold", size: 16.0)
        label.text = "Alt"
        
        return label
    }()
    private var labelBattleItem: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.font = UIFont(name: "Georgia-Bold", size: 16.0)
        label.text = "Battle Item"
        
        return label
    }()
    private var labelAltBattleItem: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.font = UIFont(name: "Georgia-Bold", size: 16.0)
        label.text = "Alt"
        
        return label
    }()
    private var stackViewMoves: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.spacing = 4
        stackView.axis = .horizontal
        stackView.alignment = .center
        
        return stackView
    }()
    private var stackViewHeldItems: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.spacing = 7
        stackView.axis = .horizontal
        stackView.alignment = .leading
        
        return stackView
    }()
    private var imageViewAltHeldItem: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    private var imageViewBattleItem: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    private var imageViewAltBattleItem: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        
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
        self.contentView.addSubview(self.viewBackground)
        self.viewBackground.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.snp.top).offset(15)
            make.left.equalTo(self.contentView.snp.left).offset(15)
            make.right.equalTo(self.contentView.snp.right).offset(-15)
            make.bottom.equalTo(self.contentView.snp.bottom)
        }
        self.viewBackground.addSubview(self.viewContainer)
        self.viewContainer.snp.makeConstraints { make in
            make.top.equalTo(self.viewBackground.snp.top).offset(20)
            make.left.equalTo(self.viewBackground.snp.left).offset(20)
            make.right.equalTo(self.viewBackground.snp.right).offset(-20)
            make.bottom.equalTo(self.viewBackground.snp.bottom).offset(-20)
        }
        
        // Moves
        self.viewContainer.addSubview(self.labelName)
        self.labelName.snp.makeConstraints { make in
            make.top.equalTo(self.viewContainer.snp.top)
            make.left.equalTo(self.viewContainer.snp.left)
        }
        self.viewContainer.addSubview(self.stackViewMoves)
        self.stackViewMoves.snp.makeConstraints { make in
            make.top.equalTo(self.labelName.snp.bottom).offset(10)
            make.left.equalTo(self.viewContainer.snp.left)
            make.right.equalTo(self.viewContainer.snp.right)
        }
        
        // Held Items
        self.viewContainer.addSubview(self.labelHeldItems)
        self.labelHeldItems.snp.makeConstraints { make in
            make.top.equalTo(self.stackViewMoves.snp.bottom).offset(20)
            make.left.equalTo(self.viewContainer.snp.left)
        }
        self.viewContainer.addSubview(self.stackViewHeldItems)
        self.stackViewHeldItems.snp.makeConstraints { make in
            make.top.equalTo(self.labelHeldItems.snp.bottom).offset(7)
            make.left.equalTo(self.viewContainer.snp.left)
            make.height.equalTo(50)
        }
        
        // Alt Held Item
        self.viewContainer.addSubview(self.labelAltHeldItem)
        self.labelAltHeldItem.snp.makeConstraints { make in
            make.top.equalTo(self.stackViewMoves.snp.bottom).offset(20)
            make.left.equalTo(self.stackViewHeldItems.snp.right).offset(40)
            make.centerY.equalTo(self.labelHeldItems.snp.centerY)
        }
        self.viewContainer.addSubview(self.imageViewAltHeldItem)
        self.imageViewAltHeldItem.snp.makeConstraints { make in
            make.top.equalTo(self.labelAltHeldItem.snp.bottom).offset(7)
            make.left.equalTo(self.labelAltHeldItem.snp.left)
            make.centerY.equalTo(self.stackViewHeldItems.snp.centerY)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        // Battle Items
        self.viewContainer.addSubview(self.labelBattleItem)
        self.labelBattleItem.snp.makeConstraints { make in
            make.top.equalTo(self.stackViewHeldItems.snp.bottom).offset(20)
            make.left.equalTo(self.viewContainer.snp.left)
        }
        self.viewContainer.addSubview(self.imageViewBattleItem)
        self.imageViewBattleItem.snp.makeConstraints { make in
            make.top.equalTo(self.labelBattleItem.snp.bottom).offset(7)
            make.left.equalTo(self.viewContainer.snp.left)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        // Alt Battle Item
        self.viewContainer.addSubview(self.labelAltBattleItem)
        self.labelAltBattleItem.snp.makeConstraints { make in
            make.top.equalTo(self.stackViewHeldItems.snp.bottom).offset(20)
            make.left.equalTo(self.labelBattleItem.snp.right).offset(40)
            make.centerY.equalTo(self.labelBattleItem.snp.centerY)
        }
        self.viewContainer.addSubview(self.imageViewAltBattleItem)
        self.imageViewAltBattleItem.snp.makeConstraints { make in
            make.top.equalTo(self.labelAltBattleItem.snp.bottom).offset(7)
            make.left.equalTo(self.labelAltBattleItem.snp.left)
            make.centerY.equalTo(self.imageViewBattleItem.snp.centerY)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
    }
}


