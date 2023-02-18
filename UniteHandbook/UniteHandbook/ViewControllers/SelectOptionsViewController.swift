//
//  SelectOptionsViewController.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/18/23.
//

import Foundation
import SnapKit
import UIKit

class SelectOptionsViewController: UIViewController {
    
    private var images: [UIImage?] = [UIImage?]()
    
    private lazy var multiImageView: MultiImageView = {
        let view = MultiImageView(frame: .zero)
        view.backgroundColor = .clear
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(hex: 0xc0b5e0)
        
        self.setup()
    }
    
    public convenience init(images: [UIImage?]) {
        self.init(nibName: nil, bundle: nil)
        self.images = images
    }
    
    private func setup() {
        
        self.view.addSubview(self.multiImageView)
        self.multiImageView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalTo(self.view.snp.left).offset(15)
            make.right.equalTo(self.view.snp.right).offset(-15)
            make.centerX.equalTo(self.view.snp.centerX)
        }

        self.multiImageView.images = self.images
    }
}
