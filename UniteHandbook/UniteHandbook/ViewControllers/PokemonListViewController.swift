//
//  PokemonListViewController.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/9/23.
//

import UIKit
import SnapKit
import IGListKit

class PokemonListViewController: UIViewController {

    public var pokemonList: [Pokemon] = [Pokemon]()
    
    private lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater.init(), viewController: self, workingRangeSize: 0)
        
        return adapter
    }()
    private var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        
        return collectionView
    }()
    
    public convenience init(pokemonList: [Pokemon]) {
        self.init(nibName: nil, bundle: nil)
        self.pokemonList = pokemonList
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
    }
    
    private func setup() {
        self.adapter.collectionView = self.collectionView
        self.adapter.dataSource = self
        
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(self.view.snp.bottom)
        }
    }
}

extension PokemonListViewController: ListAdapterDataSource {
    public func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return self.pokemonList
    }
    
    public func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if (object is Pokemon) {
            return PokemonSectionController()
        }
        
        return ListSectionController()
    }
    
    public func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
}
