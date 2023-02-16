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
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        return collectionView
    }()
    private lazy var buttonClose: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Georgia-Bold", size: 14.0)
        button.addTarget(self, action: #selector(buttonClose_TouchUpInside), for: .touchUpInside)
        button.backgroundColor = UIColor(hex: 0xF9CB53)
        button.clipsToBounds = true
        button.layer.cornerRadius = 20.0
        button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        return button
    }()
    
    public convenience init(desc: String) {
        self.init(nibName: nil, bundle: nil)
        
        self.sections.append(LevelDetailsDesc(desc: desc))
    }
    public convenience init(levelDetails: [LevelDetails]) {
        self.init(nibName: nil, bundle: nil)
        
        for details in levelDetails {
            self.sections.append(LevelDetailsLevel(title: "Level \(details.level)"))
            self.sections.append(LevelDetailsDesc(desc: details.desc))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .init(white: 0.0, alpha: 0.6)
        
        self.setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        DispatchQueue.main.async {
            self.collectionViewHeightConstraint?.update(offset: self.collectionView.contentSize.height)
            self.view.layoutIfNeeded()
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
            make.top.equalTo(self.contentView.snp.top).offset(10)
            make.left.equalTo(self.contentView.snp.left).offset(20)
            make.right.equalTo(self.contentView.snp.right).offset(-20)
            make.bottom.equalTo(self.buttonClose.snp.top).offset(-10)
            self.collectionViewHeightConstraint = make.height.equalTo(self.collectionView.contentSize.height).constraint
        }
        
        self.adapter.performUpdates(animated: true, completion: nil)
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
        if object is LevelDetailsLevel {
            return LevelDetailsLevelSectionController()
        } else if object is LevelDetailsDesc {
            return LevelDetailsDescSectionController()
        }
        
        return ListSectionController()
    }
    
    public func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
