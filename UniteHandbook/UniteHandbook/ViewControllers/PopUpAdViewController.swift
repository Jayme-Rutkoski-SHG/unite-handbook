//
//  PopUpAdViewController.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 3/22/23.
//

import Foundation
import UIKit
import SnapKit

public class PopUpAdViewController: UIViewController {
    
    private var viewModel: PopUpAdViewModel!
    
    private lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 20.0
        
        return view
    }()
    private lazy var viewHeader: UIView = {
        let view = UIView(frame: .zero)
        view.clipsToBounds = true
        view.layer.cornerRadius = 20.0
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        return view
    }()
    
    private lazy var labelHeader: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Georgia-Bold", size: 17.0)
        label.textAlignment = .center
        
        return label
    }()
    private lazy var labelMessage: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "Georgia", size: 15.0)
        
        return label
    }()

    private lazy var buttonClose: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.init(hex: 0x444444), for: .normal)
        button.titleLabel?.font = UIFont(name: "Georgia-Bold", size: 15.0)
        button.addTarget(self, action: #selector(buttonClose_TouchUpInside), for: .touchUpInside)
        button.backgroundColor = UIColor.init(hex: 0xCCCCCC)
        button.clipsToBounds = true
        button.layer.cornerRadius = 20.0
        button.layer.maskedCorners = [.layerMaxXMaxYCorner]
        
        return button
    }()
    private lazy var buttonOk: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Watch", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Georgia-Bold", size: 15.0)
        button.setImage(UIImage(named: "watch_ad")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .black
        button.addTarget(self, action: #selector(buttonOk_TouchUpInside), for: .touchUpInside)
        button.backgroundColor = UIColor.init(hex: 0x00A300)
        button.clipsToBounds = true
        button.layer.cornerRadius = 20.0
        button.layer.maskedCorners = [.layerMinXMaxYCorner]
        
        return button
    }()
    
    public convenience init(viewModel: PopUpAdViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .init(white: 0.0, alpha: 0.6)
        self.setup()
    }

    private func setup() {
        
        self.view.addSubview(self.contentView)
        self.contentView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX);
            make.centerY.equalTo(self.view.snp.centerY);
            make.left.equalTo(self.view.snp.left).offset(50);
            make.right.equalTo(self.view.snp.right).inset(50);
            make.height.equalTo(0).priority(250);
        }
        
        self.contentView.addSubview(self.viewHeader)
        self.viewHeader.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top)
            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(self.contentView.snp.right)
            make.height.greaterThanOrEqualTo(45)
        }
        
        self.viewHeader.addSubview(self.labelHeader)
        self.labelHeader.snp.makeConstraints { (make) in
            make.top.equalTo(self.viewHeader.snp.top).offset(15)
            make.left.equalTo(self.viewHeader.snp.left)
            make.right.equalTo(self.viewHeader.snp.right)
            make.centerX.equalTo(self.viewHeader.snp.centerX)
        }

        self.contentView.addSubview(self.buttonOk)
        self.buttonOk.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.contentView.snp.bottom)
            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(self.contentView.snp.centerX)
            make.height.equalTo(45)
        }
        
        self.buttonOk.imageView?.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.centerY.equalTo(self.buttonOk.titleLabel!.snp.centerY)
            make.right.equalTo(self.buttonOk.titleLabel!.snp.left).offset(-8)
        }
        
        self.contentView.addSubview(self.buttonClose)
        self.buttonClose.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.contentView.snp.bottom)
            make.left.equalTo(self.contentView.snp.centerX)
            make.right.equalTo(self.contentView.snp.right)
            make.height.equalTo(45)
        }
        
        self.contentView.addSubview(self.labelMessage)
        self.labelMessage.snp.makeConstraints { (make) in
            make.top.equalTo(self.viewHeader.snp.bottom).offset(15)
            make.left.equalTo(self.contentView.snp.left).offset(10)
            make.right.equalTo(self.contentView.snp.right).offset(-10)
            make.centerX.equalTo(self.viewHeader.snp.centerX)
            make.bottom.equalTo(self.buttonClose.snp.top).offset(-15);
        }
        
        self.viewHeader.backgroundColor = self.viewModel.headerBackgroundColor
        self.labelHeader.text = self.viewModel.title
        self.labelHeader.textColor = self.viewModel.headerTextColor
        self.labelMessage.text = self.viewModel.message
    }
    
    @objc private func buttonOk_TouchUpInside(sender: UIButton) {
        self.dismiss(animated: true) {
            self.viewModel.willWatch()
        }        
    }
    @objc private func buttonClose_TouchUpInside(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

