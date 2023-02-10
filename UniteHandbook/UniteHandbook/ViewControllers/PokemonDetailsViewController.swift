//
//  PokemonDetailsViewController.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/10/23.
//

import UIKit
import SnapKit
import IGListKit

class PokemonDetailsViewController: UIViewController {

    private var pokemon: Pokemon = Pokemon()
    
    private lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor(hex:0xFCA97B).cgColor, UIColor(hex:0xA971A2).cgColor]
        layer.startPoint = CGPoint(x:0, y:0)
        layer.endPoint = CGPoint(x:0, y:1)
        layer.anchorPoint = CGPointZero;
        layer.frame = self.view.bounds
        
        return layer
    }()
    
    private var viewContainer: UIView = {
        let view = UIView(frame: .zero)
        
        return view
    }()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    private var viewAttackerStyle: UIView = {
        let view = UIView(frame: .zero)
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private var labelName: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.font = UIFont(name: "Georgia-Bold", size: 24.0)
        
        return label
    }()
    
    private var labelAttackerStyle: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.textAlignment = .left
        button.titleLabel?.font = UIFont(name: "Georgia", size: 15.0)
        button.layer.cornerRadius = 12.5
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 0.5
        
        return button
    }()
    
    private var labelRole: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.textAlignment = .left
        button.titleLabel?.font = UIFont(name: "Georgia", size: 15.0)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex:0x3B275E)
        button.layer.cornerRadius = 12.5
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 0.5
        
        return button
    }()
    private var labelStyle: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.textAlignment = .left
        button.titleLabel?.font = UIFont(name: "Georgia", size: 15.0)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex:0x3B275E)
        button.layer.cornerRadius = 12.5
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 0.5
        
        return button
    }()
    private var labelDifficulty: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.textAlignment = .left
        button.titleLabel?.font = UIFont(name: "Georgia", size: 15.0)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex:0x3B275E)
        button.layer.cornerRadius = 12.5
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 0.5
        
        return button
    }()
    
    private lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater.init(), viewController: self, workingRangeSize: 0)
        
        return adapter
    }()
    private var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsVerticalScrollIndicator = false
        
        return collectionView
    }()
    
    public convenience init(pokemon: Pokemon) {
        self.init(nibName: nil, bundle: nil)
        self.pokemon = pokemon
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.view.layer.insertSublayer(self.gradientLayer, at: 0)
    }
    
    private func setup() {
        self.imageView.image = UIImage(named: self.pokemon.name.lowercased())
        self.labelName.text = self.pokemon.name
        self.labelAttackerStyle.setTitle(self.pokemon.attackStyle.lowercased() == "attack" ? "Physical Attacker" : "Special Attacker", for: .normal)
        self.labelAttackerStyle.backgroundColor = self.pokemon.attackStyle.lowercased() == "attack" ? UIColor(hex: 0xEDB544) : UIColor(hex: 0xC974DB)
        self.labelRole.setTitle(self.pokemon.role, for: .normal)
        self.labelStyle.setTitle(self.pokemon.style, for: .normal)
        self.labelDifficulty.setTitle(self.pokemon.difficulty, for: .normal)
        
        self.adapter.collectionView = self.collectionView
        self.adapter.dataSource = self
        
        self.view.addSubview(self.viewContainer)
        self.viewContainer.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalTo(self.view.snp.left).offset(15)
            make.right.equalTo(self.view.snp.right).offset(-15)
            make.bottom.equalTo(self.view.snp.bottom)
        }
        
        self.viewContainer.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { make in
            make.top.equalTo(self.viewContainer.snp.top)
            make.left.equalTo(self.viewContainer.snp.left)
            make.height.equalTo(115)
            make.width.equalTo(115)
        }
        self.viewContainer.addSubview(self.labelName)
        self.labelName.snp.makeConstraints { make in
            make.top.equalTo(self.viewContainer.snp.top)
            make.left.equalTo(self.imageView.snp.right).offset(12)
        }
        
        self.viewContainer.addSubview(self.labelAttackerStyle)
        self.labelAttackerStyle.snp.makeConstraints { make in
            make.top.equalTo(self.viewContainer.snp.top)
            make.right.equalTo(self.viewContainer.snp.right)
            make.height.equalTo(25)
        }
        self.viewContainer.addSubview(self.labelRole)
        self.labelRole.snp.makeConstraints { make in
            make.top.equalTo(self.labelAttackerStyle.snp.bottom).offset(5)
            make.right.equalTo(self.viewContainer.snp.right)
            make.height.equalTo(25)
        }
        self.viewContainer.addSubview(self.labelStyle)
        self.labelStyle.snp.makeConstraints { make in
            make.top.equalTo(self.labelRole.snp.bottom).offset(5)
            make.right.equalTo(self.viewContainer.snp.right)
            make.height.equalTo(25)
        }
        self.viewContainer.addSubview(self.labelDifficulty)
        self.labelDifficulty.snp.makeConstraints { make in
            make.top.equalTo(self.labelStyle.snp.bottom).offset(5)
            make.right.equalTo(self.viewContainer.snp.right)
            make.height.equalTo(25)
        }
    }
}

extension PokemonDetailsViewController: ListAdapterDataSource {
    public func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [ListDiffable]()
    }
    
    public func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        
        return ListSectionController()
    }
    
    public func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
}
