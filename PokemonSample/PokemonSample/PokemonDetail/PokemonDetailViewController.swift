//
//  PokemonDetailViewController.swift
//  PokemonSample
//
//  Created by kensho hanano on 2023/01/05.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    var mPokemon: Pokemon!

    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        // Do any additional setup after loading the view.
    }
    
    private func initView() {
        if mPokemon != nil {
            let url = URL(string: mPokemon.sprites.frontImage)
            ImageManager.setImage(target: imageView, url: url)
            number.text = "No.\(mPokemon.id)"
            name.text = mPokemon.name
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
