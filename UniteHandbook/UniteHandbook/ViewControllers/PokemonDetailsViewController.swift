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
    private var abilitiesArray: [BaseListDiffable] = [BaseListDiffable]()
    private var buildsArray: [BaseListDiffable] = [BaseListDiffable]()
    private var statsArray: [BaseListDiffable] = [BaseListDiffable]()
    
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
    
    private lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(frame: .zero)
        control.insertSegment(withTitle: "Abilities", at: 0, animated: false)
        control.insertSegment(withTitle: "Builds", at: 1, animated: false)
        control.insertSegment(withTitle: "Stats", at: 2, animated: false)
        
        control.selectedSegmentTintColor = UIColor(hex: 0xF9CB53)
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: .selected)
        control.backgroundColor = UIColor(hex: 0x3B276B)
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        
        return control
    }()
    
    private lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater.init(), viewController: self, workingRangeSize: 0)
        
        return adapter
    }()
    private var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.layer.cornerRadius = 20
        collectionView.backgroundColor = UIColor(hex: 0xAFFEFF)
        collectionView.layer.borderWidth = 1.5
        collectionView.layer.borderColor = UIColor.black.cgColor
        
        return collectionView
    }()
    
    public convenience init(pokemon: Pokemon) {
        self.init(nibName: nil, bundle: nil)
        self.pokemon = pokemon
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.createSections()
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
        
        self.viewContainer.addSubview(self.segmentedControl)
        self.segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(self.imageView.snp.bottom).offset(10)
            make.left.equalTo(self.viewContainer.snp.left)
            make.right.equalTo(self.viewContainer.snp.right)
        }
        
        self.viewContainer.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.segmentedControl.snp.bottom).offset(15)
            make.left.equalTo(self.viewContainer.snp.left)
            make.right.equalTo(self.viewContainer.snp.right)
            make.bottom.equalTo(self.viewContainer.snp.bottom)
        }
    }
    
    private func createSections() {
        // Abilities
        self.abilitiesArray.append(AbilityDetails(
            imageName: "\(self.pokemon.name.lowercased())_\(self.pokemon.ability.name.replacingOccurrences(of: " ", with: "").lowercased()).png",
            name: self.pokemon.ability.name,
            desc: self.pokemon.ability.desc))
        
        if let moves = convertMovesToMoveDetailsArray(moves: self.pokemon.moves) {
            var count = 0
            for move in moves {
                count+=1
                self.abilitiesArray.append(HeaderDivider(title: "Move \(count)"))
                self.abilitiesArray.append(move)
            }
        }
        
        self.abilitiesArray.append(HeaderDivider(title: "Unite Move"))
        self.abilitiesArray.append(MoveDetails(
            imageName: "\(self.pokemon.name.lowercased())_\(self.pokemon.unite.name.replacingOccurrences(of: " ", with: "").lowercased()).png",
            name: self.pokemon.unite.name,
            category: self.pokemon.unite.category,
            cooldown: self.pokemon.unite.cooldown,
            levelDetails: self.pokemon.unite.levelDetails,
            upgrades: nil))
        
        // Stats
        // TODO: Implement some stat section slider
        self.setStatsForLevel(1)
    }
    
    private func convertMovesToMoveDetailsArray(moves: [Move]?) -> [MoveDetails]? {
        guard let moves = moves else { return nil }
        var result = [MoveDetails]()
        for move in moves {
            result.append(MoveDetails(
                imageName: "\(self.pokemon.name.lowercased())_\(move.name.replacingOccurrences(of: " ", with: "").lowercased()).png",
                name: move.name,
                category: move.category,
                cooldown: move.cooldown,
                levelDetails: move.levelDetails,
                upgrades: convertMovesToMoveDetailsArray(moves: move.upgrades)))
        }
        return result
    }
    
    private func setStatsForLevel(_ level: Int) {
        var stats = self.pokemon.stats.first(where: { $0.level == level })

        if let stats = stats {
            self.statsArray.removeAll()
            
            self.statsArray.append(StatSection(title: "HP", value: "\(stats.hp)"))
            self.statsArray.append(StatSection(title: "Attack", value: "\(stats.attack)"))
            self.statsArray.append(StatSection(title: "Defense", value: "\(stats.defense)"))
            self.statsArray.append(StatSection(title: "Sp. Attack", value: "\(stats.spAttack)"))
            self.statsArray.append(StatSection(title: "Sp. Defense", value: "\(stats.spDefense)"))
            self.statsArray.append(StatSection(title: "Critical-Hit Rate", value: "\(Int(stats.critRate * 100))%"))
            self.statsArray.append(StatSection(title: "CD Reduction", value: "\(Int(stats.cdr * 100))%"))
            self.statsArray.append(StatSection(title: "Lifesteal", value: "\(Int(stats.lifesteal * 100))%"))
        }
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        self.adapter.performUpdates(animated: false)
        self.adapter.reloadData()
    }
}

extension PokemonDetailsViewController: ListAdapterDataSource {
    public func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        if self.segmentedControl.selectedSegmentIndex == 0 {
            return self.abilitiesArray
        } else if self.segmentedControl.selectedSegmentIndex == 1 {
            return self.buildsArray
        } else if self.segmentedControl.selectedSegmentIndex == 2 {
            return self.statsArray
        }
        return [ListDiffable]()
    }
    
    public func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        
        if object is AbilityDetails {
            return AbilitiesSectionController(delegate: self)
        } else if object is MoveDetails {
            return MoveSectionController(delegate: self)
        } else if object is HeaderDivider {
            return HeaderDividerSectionController()
        } else if object is StatSection {
            return StatSectionController()
        }
        
        return ListSectionController()
    }
    
    public func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
}

extension PokemonDetailsViewController : AbilitiesSectionControllerDelegate {
    func didSelectAbilityInfo(desc: String) {
        let vc = PokemonLevelDetailsViewController(desc: desc)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        self.present(vc, animated: true)
    }
}

extension PokemonDetailsViewController : MoveSectionControllerDelegate {
    func didSelectMoveInfo(levelDetails: [LevelDetails]) {
        let vc = PokemonLevelDetailsViewController(levelDetails: levelDetails)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        self.present(vc, animated: true)
    }
    
    func showUpgrades(forMove: MoveDetails, upgrades: [MoveDetails], shouldAddUpgrades: Bool) {
        let index: Int? = self.abilitiesArray.firstIndex(where: {$0 == forMove})
        var newObjects: [BaseListDiffable] = upgrades
        if index != nil {
            let startIndex = index!+1
            newObjects.insert(HeaderDivider(title: "\(forMove.name) Upgrade Choices", isSubHeader: true), at: 0)
            if shouldAddUpgrades {
                self.abilitiesArray.insert(contentsOf: newObjects, at: startIndex)
            } else {
                self.abilitiesArray.removeSubrange(startIndex...startIndex+newObjects.count-1)
            }
            
            self.adapter.performUpdates(animated: true)
            self.adapter.reloadObjects(newObjects)
        }
    }
}
