//
//  BuildMovesCollectionViewCell.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/15/23.
//

import UIKit
import SnapKit

class BuildMovesCollectionViewCell: UICollectionViewCell {
    
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
                    
                    let imageViewNext = UIImageView(image: UIImage(named: "next_arrow.png"))
                    imageViewNext.contentMode = .scaleAspectFit
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
    
    private var viewContainer: UIView = {
        let view = UIView(frame: .zero)
        
        return view
    }()
    private var labelName: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.font = UIFont(name: "Georgia-Bold", size: 18.0)
        
        return label
    }()
    private var stackViewMoves: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.spacing = 7
        stackView.axis = .horizontal
        stackView.alignment = .center
        
        return stackView
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    override func prepareForReuse() {
        self.labelName.text = ""
        for subview in stackViewMoves.arrangedSubviews {
            subview.removeFromSuperview()
        }
    }
    
    private func setup() {
        self.contentView.addSubview(self.viewContainer)
        self.viewContainer.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.snp.top).offset(15)
            make.left.equalTo(self.contentView.snp.left).offset(15)
            make.right.equalTo(self.contentView.snp.right).offset(-15)
            make.bottom.equalTo(self.contentView.snp.bottom)
        }
        self.viewContainer.addSubview(self.labelName)
        self.labelName.snp.makeConstraints { make in
            make.top.equalTo(self.viewContainer.snp.top)
            make.left.equalTo(self.viewContainer.snp.left)
        }
        self.viewContainer.addSubview(self.stackViewMoves)
        self.stackViewMoves.snp.makeConstraints { make in
            make.top.equalTo(self.labelName.snp.bottom).offset(10)
            make.left.equalTo(self.viewContainer.snp.left)
            make.bottom.equalTo(self.viewContainer.snp.bottom)
        }
    }
}

