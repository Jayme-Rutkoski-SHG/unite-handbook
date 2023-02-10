//
//  PokemonListViewController.swift
//  UniteHandbook
//
//  Created by Jayme Rutkoski on 2/9/23.
//

import UIKit

class PokemonListViewController: UIViewController {

    public var pokemonList: [Pokemon] = [Pokemon]()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        view.dataSource = self
        view.delegate = self

        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
        
        return cell
    }

}

extension PokemonListViewController : UICollectionViewDelegate {
    
}
