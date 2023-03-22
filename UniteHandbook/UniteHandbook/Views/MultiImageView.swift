//
//  MultiImageView.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/18/23.
//

import Foundation
import UIKit

protocol MultiImageViewDelegate: AnyObject {
    func imageSelected()
}
class MultiImageView: UIView {
    
    weak var delegate: MultiImageViewDelegate?
    var images: [MultiImage] = [] {
        didSet {
            addImageViews()
        }
    }
    
    let imageHeight:CGFloat = 60
    let imagePadding: CGFloat = 16
    let imageSpacingX: CGFloat = 15
    let imageSpacingY: CGFloat = 15

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
        /*while self.subviews.count > (images.count * 2) {
            self.subviews[0].removeFromSuperview()
        }*/
        
        // if we don't have enough labels, create and add as needed
        while self.subviews.count < (images.count * 2) {

            // create a new label
            let newView = ImageTitleView()
            
            // set its properties (title, colors, corners, etc)
            newView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(tapGestureRecognizer:))))

            addSubview(newView)
        }

        // now loop through labels and set text and size
        for (img, v) in zip(images, self.subviews) {
            if let view = v as? ImageTitleView {
                view.labelText = img.text ?? ""
                view.image = img.image
                view.frame.size.width = view.getViewWidth()
                view.frame.size.height = view.getViewHeight()
            }
        }

    }
    
    func displayTagLabels() {
        
        var oldCurrentOriginX: CGFloat = 0
        var currentOriginX: CGFloat = 0
        var currentOriginY: CGFloat = 0

        // for each label in the array
        self.subviews.forEach { v in
            
            if let view = v as? ImageTitleView {
                // if current X + label width will be greater than container view width
                //  "move to next row"
                if currentOriginX + view.frame.width > bounds.width {
                    currentOriginX = 0
                    currentOriginY += view.getViewHeight() + imageSpacingY
                }
                
                // set the btn frame origin
                view.frame.origin.x = currentOriginX
                view.frame.origin.y = currentOriginY
                
                // increment current X by btn width + spacing
                currentOriginX += view.frame.width + imageSpacingX
            }
        }
        
        // update intrinsic height
        intrinsicHeight = currentOriginY + imageHeight + 20
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
        let tappedView = tapGestureRecognizer.view as! ImageTitleView
        let currentTapped = self.images.first(where: { $0.image == tappedView.image} )
        if let currentTapped = currentTapped {
            currentTapped.onSelected(currentTapped.image, currentTapped.key)
        }
        self.delegate?.imageSelected()
    }
}

struct MultiImage {
    
    public var image: UIImage?
    public var text: String?
    public var key: Any
    public var onSelected: ((UIImage?, Any) -> ())
    
    public init(image: UIImage? = nil, text: String? = nil, key: Any, onSelected: @escaping ((UIImage?, Any) -> ())) {
        self.image = image
        self.text = text
        self.key = key
        self.onSelected = onSelected
    }
}
