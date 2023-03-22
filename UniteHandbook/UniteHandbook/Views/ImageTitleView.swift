//
//  ImageTitleView.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 3/21/23.
//

import Foundation
import UIKit
import SnapKit

class ImageTitleView: UIView {
    
    public var labelText: String = "" {
        didSet {
            self.label.text = self.labelText
        }
    }
    public var image: UIImage? = nil {
        didSet {
            self.imageView.image = self.image
        }
    }
    var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Georgia", size: 13.0)
        label.textAlignment = .center
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
        self.addSubview(self.label)
        self.label.snp.makeConstraints { make in
            make.top.equalTo(self.imageView.snp.bottom).offset(3)
            make.centerX.equalTo(self.imageView.snp.centerX)
        }
    }
    
    public func getViewWidth() -> CGFloat {
        var labelString: NSString = NSString(string: self.labelText)
        var stringSize = labelString.size(withAttributes: [.font:UIFont(name: "Georgia", size: 13.0)])
        
        if stringSize.width > 60 {
            return stringSize.width
        }
        
        return 60
    }
    
    public func getViewHeight() -> CGFloat {
        var height: CGFloat = 60
        
        if self.labelText.count > 0 {
            var labelString: NSString = NSString(string: self.labelText)
            var stringSize = labelString.size(withAttributes: [.font:UIFont(name: "Georgia", size: 13.0)])
            
            height = height + stringSize.height + 3
        }
        
        return height
    }
}
