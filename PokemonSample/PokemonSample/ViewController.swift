//
//  ViewController.swift
//  PokemonSample
//
//  Created by kensho hanano on 2022/12/09.
//

import UIKit

class ViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }    
    
    private let sideMargin: CGFloat = 25
    private let itemPerWidth: CGFloat = 3
    private let itemSpacing: CGFloat = 10
    
    private var mPokemons = [Pokemon]()
    private var currentPokemon: Pokemon!
    
    // レイアウト設定　UIEdgeInsets については下記の参考図を参照。
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 2.0, bottom: 2.0, right: 2.0)
    // 1行あたりのアイテム数
    private let itemsPerRow: CGFloat = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        featchPokemons()
        
    }
    
    private func initView() {
        // レイアウトを調整
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(
            top: 12,
            left: sideMargin,
            bottom: 12,
            right: sideMargin
        )
    }
    
    
    private func featchPokemons() {
        Task {
            do {
                let pokemons = try await PokemonApiClient.fetchPokemonList()
                DispatchQueue.main.async {
                    self.mPokemons = pokemons
                    print("collectionView \(self.collectionView.hashValue)")
                    if(self.collectionView != nil) {
                        print("nilではない")
                        self.collectionView.reloadData()
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    print("Error")
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPokemonDetail" {
            let nextView = segue.destination as! PokemonDetailViewController
            nextView.mPokemon = currentPokemon
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // cellの数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("pokemonの数 \(self.mPokemons.count)")
        return self.mPokemons.count
    }
    
    // cellの初期化？
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        cell.layer.cornerRadius = 85
        let number = cell.contentView.viewWithTag(1) as! UILabel
        let name = cell.contentView.viewWithTag(2) as! UILabel
        let imageView = cell.contentView.viewWithTag(3) as! UIImageView
        let url = URL(string: self.mPokemons[indexPath.row].sprites.frontImage)
        ImageManager.setImage(target: imageView, url: url)
        number.text = "No.\(self.mPokemons[indexPath.row].id)"
        name.text = self.mPokemons[indexPath.row].name
        return cell
    }
    
    // cellタップ時
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentPokemon = mPokemons[indexPath.row]
        performSegue(withIdentifier: "toPokemonDetail", sender: nil)
        print("\(indexPath.row + 1)がtapされたよ")
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let horizontalSpace : CGFloat = 30
        let cellSize : CGFloat = self.view.bounds.width / itemsPerRow - horizontalSpace
        return CGSize(width: cellSize, height: cellSize)
    }
}

