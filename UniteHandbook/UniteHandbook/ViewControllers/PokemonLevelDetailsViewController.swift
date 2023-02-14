//
//  PokemonLevelDetailsViewController.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/13/23.
//

import UIKit
import SnapKit
import IGListKit

class PokemonLevelDetailsViewController: UIViewController {

    private var cellHeight: CGFloat = 0.0
    private var collectionViewHeightConstraint: Constraint?
    
    private var sections: [BaseListDiffable] = [BaseListDiffable]()
    
    private lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater.init(), viewController: self, workingRangeSize: 0)
        
        return adapter
    }()
    private lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 20.0
        
        return view
    }()
    private var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        return collectionView
    }()
    private lazy var buttonClose: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Georgia-Bold", size: 14.0)
        button.addTarget(self, action: #selector(buttonClose_TouchUpInside), for: .touchUpInside)
        button.backgroundColor = UIColor(hex: 0x3B276B)
        button.clipsToBounds = true
        button.layer.cornerRadius = 20.0
        button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        return button
    }()
    
    public convenience init(desc: String) {
        self.init(nibName: nil, bundle: nil)
        
    }
    public convenience init(levelDetails: [LevelDetails]) {
        self.init(nibName: nil, bundle: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .init(white: 0.0, alpha: 0.6)
        
        self.setup()
    }
    
    override func viewWillLayoutSubviews() {
        let height = self.collectionView.collectionViewLayout.collectionViewContentSize.height
        self.cellHeight = height / CGFloat(self.sections.count > 0 ? self.sections.count : 1)
        DispatchQueue.main.async {
            self.collectionViewHeightConstraint?.update(offset: self.calculateCollectionViewHeight())
        }
    }

    private func setup() {
        self.adapter.collectionView = self.collectionView
        self.adapter.dataSource = self
           
        self.view.addSubview(self.contentView)
        self.contentView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX);
            make.centerY.equalTo(self.view.snp.centerY);
            make.left.equalTo(self.view.snp.left).offset(50);
            make.right.equalTo(self.view.snp.right).inset(50);
            make.height.equalTo(0).priority(250);
        }

        self.contentView.addSubview(self.buttonClose)
        self.buttonClose.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.contentView.snp.bottom)
            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(self.contentView.snp.right)
            make.height.equalTo(50)
        }
            
        self.contentView.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top)
            make.left.equalTo(self.contentView.snp.left).offset(10)
            make.right.equalTo(self.contentView.snp.right).offset(-10)
            make.bottom.equalTo(self.buttonClose.snp.top).offset(-5)
            self.collectionViewHeightConstraint = make.height.equalTo(self.calculateCollectionViewHeight()).constraint
        }
    }
    
    private func calculateCollectionViewHeight() -> CGFloat {
        if (sections.count > 0 && self.cellHeight > 0) {
            let maxHeight = UIScreen.main.bounds.size.height - 200
            let desiredHeight = CGFloat(sections.count) * self.cellHeight
            if (desiredHeight > maxHeight) {
                return maxHeight
            } else {
                return desiredHeight
            }
        } else {
            return 50
        }
    }
    
    @objc private func buttonClose_TouchUpInside(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PokemonLevelDetailsViewController: ListAdapterDataSource {
    public func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return self.sections
    }
    
    public func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {

        return ListSectionController()
    }
    
    public func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
