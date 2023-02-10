//
//  PokemonListViewController.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/9/23.
//

import UIKit
import SnapKit

class PokemonListViewController: UIViewController {

    public var pokemonList: [Pokemon] = [Pokemon]()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        view.dataSource = self
        view.delegate = self

        return view
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
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
    }
}

extension PokemonListViewController : UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pokemonList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCollectionViewCell", for: indexPath) as! PokemonCollectionViewCell
        cell.name = self.pokemonList[indexPath.row].name
        
        return cell
    }

}

extension PokemonListViewController : UICollectionViewDelegate {
    
}
