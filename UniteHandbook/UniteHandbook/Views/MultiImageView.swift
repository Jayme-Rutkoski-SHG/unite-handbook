//
//  MultiImageView.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/18/23.
//

import Foundation
import UIKit

protocol MultiImageViewDelegate {
    func imageSelected()
}
class MultiImageView: UIView {
    
    var delegate: MultiImageViewDelegate?
    var images: [MultiImage] = [] {
        didSet {
            addImageViews()
        }
    }
    
    let imageHeight:CGFloat = 60
    let imagePadding: CGFloat = 16
    let imageSpacingX: CGFloat = 12
    let imageSpacingY: CGFloat = 12

    var intrinsicHeight: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() -> Void {
    }

    func addImageViews() -> Void {
        
        // if we already have tag labels (or buttons, etc)
        //  remove any excess (e.g. we had 10 tags, new set is only 7)
        while self.subviews.count > images.count {
            self.subviews[0].removeFromSuperview()
        }
        
        // if we don't have enough labels, create and add as needed
        while self.subviews.count < images.count {

            // create a new label
            let newImageView = UIImageView()
            
            
            // set its properties (title, colors, corners, etc)
            newImageView.isUserInteractionEnabled = true
            newImageView.contentMode = .scaleAspectFit
            newImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(tapGestureRecognizer:))))

            addSubview(newImageView)
            
        }

        // now loop through labels and set text and size
        for (img, v) in zip(images, self.subviews) {
            guard let imageView = v as? UIImageView else {
                fatalError("non-UIImageView subview found!")
            }
            imageView.image = img.image
            imageView.frame.size.width = imageHeight
            imageView.frame.size.height = imageHeight
        }

    }
    
    func displayTagLabels() {
        
        var currentOriginX: CGFloat = 0
        var currentOriginY: CGFloat = 0

        // for each label in the array
        self.subviews.forEach { v in
            
            guard let imageView = v as? UIImageView else {
                fatalError("non-UIImageView subview found!")
            }

            // if current X + label width will be greater than container view width
            //  "move to next row"
            if currentOriginX + imageView.frame.width > bounds.width {
                currentOriginX = 0
                currentOriginY += imageHeight + imageSpacingY
            }
            
            // set the btn frame origin
            imageView.frame.origin.x = currentOriginX
            imageView.frame.origin.y = currentOriginY
            
            // increment current X by btn width + spacing
            currentOriginX += imageView.frame.width + imageSpacingX
            
        }
        
        // update intrinsic height
        intrinsicHeight = currentOriginY + imageHeight
        invalidateIntrinsicContentSize()
        
    }

    // allow this view to set its own intrinsic height
    override var intrinsicContentSize: CGSize {
        var sz = super.intrinsicContentSize
        sz.height = intrinsicHeight
        return sz
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        displayTagLabels()
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let currentTapped = self.images.first(where: { $0.image == tappedImage.image} )
        if let currentTapped = currentTapped {
            currentTapped.onSelected(currentTapped.image, currentTapped.key)
        }
        self.delegate?.imageSelected()
    }
}

struct MultiImage {
    
    public var image: UIImage?
    public var key: Any
    public var onSelected: ((UIImage?, Any) -> ())
    
    public init(image: UIImage? = nil, key: Any, onSelected: @escaping ((UIImage?, Any) -> ())) {
        self.image = image
        self.key = key
        self.onSelected = onSelected
    }
}
